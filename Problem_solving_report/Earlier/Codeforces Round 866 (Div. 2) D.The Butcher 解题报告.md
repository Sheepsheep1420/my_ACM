## Codeforces Round 866 (Div. 2) D.The Butcher 解题报告

#### 题意

现有一块  **h*w**  的矩形 ， 可以执行  **n-1** 次操作：

· 将一个矩形水平或垂直地切成两块，然后将其中一块放进盒子里(此后不再考虑)。

![image-20230416193456920](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230416193456920.png)

操作结束后，将最后一块矩形放进盒子里，这样一共有n个矩形快。

现在给出n个矩形块的长和宽，它们是乱序的，但没有经过旋转。要求还原出 **h** 和 **w** 的值。



#### 分析：

第一次剪裁后，一定会留下一个矩形，它带有完整的 **w** 或者完整的 **h** 。也就是说在所有矩形中找到的最长边，可能是原始矩形的 **w** 或者 **h** 。分别检验一下。

```c++
#include<bits/stdc++.h>
using namespace std ;
#define ll long long
#define double long double
const ll N = 2e5+9 ;
const ll INF = 1e18 ;
const ll mod = 1e9+7 ;
//const double pi = acos(-1) ;
const double eps = 1e-9 ;
vector<pair<ll,ll>>p ;
ll n , sum ;
bool check( ll x ){
    multiset<pair<ll,ll>>s[2] ;
    for( auto u : p ){
        s[ 0 ].insert( {u.first,u.second} ) ;
        s[ 1 ].insert( {u.second,u.first} ) ;
    }
    ll cur = x , len = sum/x ; //确定了一条边另外的一条边也确定了

    for( int i = 0 ; !s[i].empty() ; i ^= 1 ){
        //把所有保留cur边的矩形拼起来
       if( s[i].rbegin()->first != cur ) return 0 ; //如果它没法被拼起来
       while( !s[i].empty() && s[i].rbegin()->first == cur ){
            ll x = s[i].rbegin()->first ;
            ll y = s[i].rbegin()->second ;
            s[i].erase( s[i].lower_bound( {x,y} ) ) ;
            s[i^1].erase( s[i^1].lower_bound( {y,x} ) ) ;
            len -= y ;
       }
       swap( cur , len ) ;
    }
    return cur == 0 ;
}
void solve(){
    cin >> n ; sum = 0 ;
    p.clear() ; p.resize( n ) ;
    ll max1 = 0 , max2 = 0 ;
    for( int i = 0 ; i < n ; i ++ ){
        cin >> p[ i ].first >> p[ i ].second ;
        sum += p[i].first*p[i].second ;
        max1 = max( max1 , p[i].first ) ;
        max2 = max( max2 , p[i].second ) ;
    }

    set<pair<ll,ll>> ans ;

    if( sum%max1 == 0 && check(max1) ) ans.insert( {max1,sum/max1} ) ;

    for( int i = 0 ; i < n ; i ++ ) swap( p[i].first , p[i].second ) ;

    if( sum%max2 == 0 && check(max2) ) ans.insert( {sum/max2,max2} ) ;

    cout << ans.size() << "\n" ;
    for( auto u : ans ) cout << u.first << " " << u.second << "\n" ;

}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}

```























































