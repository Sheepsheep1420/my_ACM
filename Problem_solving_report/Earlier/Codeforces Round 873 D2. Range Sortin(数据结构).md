## Codeforces Round 873 D2. Range Sorting (Hard Version)

- #### 题意

----------

​		对一个数组 $\{p_i\}$ 的一段区间 $[l,r]$ 排序的代价为 $r-l$ ，对整个数组 $p_i$ 排序的代价为选定若干区间并排序，使得整个数组有序的代价之和。

​		求 $\{a_i\}$ 的所有子段排序的代价之和。

- #### 分析

--------

​		如果将所有的区间都排序，代价是 $\sum_{i=2}^{n}((i-1)*i)/2$。

​		对于所有区间，可能会存在一个区间 $[l,r]$，同时它存在一个分界点 $i$ 使得分别对 $[l,i]$ 和 $[i+1,r]$ 排序比对 $[l,r]$ 排序更优，代价省去 $1$。考虑找到这样的区间，计算所有可以省去的代价。

​		对于 $[l,r]$ 若它分成两次排序会更优，则一定有 $[l,i]$ 中的最大值小于 $[i+1,r]$ 中的最小值。考虑枚举前半段的最大值$x$，位置为 $b$。找到 $b$ 位置前一个比 $x$ 大的数，位置为 $a$ ；后一个比 $x$ 大的数，位置为 $c$；$c$ 后面第一个比 $x$ 小的数，位置为$d$。

​		![image-20230531203014589](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230531203014589.png)

​		这样前半段的左端点可以在 $[a+1,b]$ 中选择，右端点一定是 $c-1$，后半段的左端点一定是 $c$，右端点可以在 $[c,d-1]$ 中选择，可以省去的代价为 $(b-a)*(d-c)$。

- #### 代码实现

--------

​		开两个 $set$,$s_1$ 存放比当前的 $x$ 要大的数的下标，$s2$ 中存放比当前的 $x$ 小的数的下标。

```cpp
sort(id+1,id+n+1,[&](int i,int j){return a[i]<a[j];});
```

​		$id[i]$ 表示 $a$ 数组排序后排在第 $i$ 位的数在原来的 $a$ 数组中的下标。

```cpp
#include<bits/stdc++.h>
using namespace std ;
#define ll long long
#define double long double
const ll N = 1e6+9 ;
const ll INF = 1e17 ;
const ll mod = 1e9+7 ;
//const double pi = acos(-1) ;
const double eps = 1e-7 ;
ll gcd( ll a , ll b ){ return a == 0 ? b : gcd( b%a , a ) ; }
ll lcm( ll a , ll b ){ return (a/gcd(a,b))*b ; }
ll Abs( ll x ){ return x < 0 ? -x : x ; }
ll n , a[ N ] , id[ N ] ;
void solve(){

    ll ans = 0 ;

    cin >> n ; for( ll i = 1 ; i <= n ; i ++ ){
        cin >> a[ i ] ; id[ i ] = i ; ans += ( i-1 )*i/2 ;
    }
    sort( id+1 , id+1+n , [&]( ll x , ll y ){ return a[x] < a[y] ; } ) ;
    set<ll>s1,s2 ;
    for( int i = 0 ; i <= n+1 ; i ++ ) s1.emplace( i ) ; s2.emplace(0) ; s2.emplace(n+1) ;

    for( int i = 1 ; i <= n ; i ++ ){
        ll a , b , c , d ; b = id[ i ] ;
        a = *(--s1.lower_bound(b)) ;
        c = *(s1.upper_bound(b)) ;
        if( c != n+1 ){
            d = *s2.lower_bound( c ) ;
            ans -= (d-c)*(b-a) ;
        }
        s1.erase(b) ; s2.emplace(b) ;
    }
    cout << ans << "\n" ;
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}

```

