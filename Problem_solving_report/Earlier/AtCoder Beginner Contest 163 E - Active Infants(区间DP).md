## AtCoder Beginner Contest 163 E - Active Infants(区间DP)

#### 题意：

有 $N$个小孩，第 $i$ 个孩子的位置为 $pos_i$，活跃值为 $A_i$，现在将 $N$ 个小孩重新排列，每个小孩获得的开心值为 $A_i*|i-pos_i|$ 与重新排列前后位置差的乘积，求最大可能的开心值总和。

#### 分析：

区间DP。最大的放在尽可能远的地方会更优，可以放左边或者放右边。

#### 代码:

(递推，从小往大放)

```C++
#include<bits/stdc++.h>
using namespace std;
#define ll long long
const ll N = 2e3+9 ;
const ll mod = 1e9+7 ;
const ll INF = 1e18 ;
ll Abs( ll x ){ return x < 0 ? -x : x ; }
ll dp[ N ][ N ] , n ;
pair<ll,ll>a[ N ] ;
void solve(){
    cin >> n ; for( int i = 1 ; i <= n ; i ++ ){
        cin >> a[ i ].first ; a[ i ].second = i ;
    }
    sort( a+1 , a+1+n ) ;
    for( int len = 1 ; len <= n ; len ++ )
        for( int l = 1 , r = len ; r <= n ; l++ , r ++ )
            if( l == r ) dp[l][r] = a[len].first*Abs(l-a[len].second) ;
            else dp[ l ][ r ] = max( dp[l+1][r]+a[len].first*Abs(l-a[len].second) , dp[l][r-1]+a[len].first*Abs(r-a[len].second) ) ;
    cout << dp[1][n] << "\n" ;
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}

```

(记忆化搜索，从大往小放)

```c++
#include<bits/stdc++.h>
using namespace std;
#define ll long long
const ll N = 2e3+9 ;
const ll mod = 1e9+7 ;
const ll INF = 1e18 ;
ll Abs( ll x ){ return x < 0 ? -x : x ; }
ll dp[ N ][ N ] , n ;
pair<ll,ll>a[ N ] ;
ll DP( ll i , ll l , ll r ){
    if( l > r ) return 0 ;
    if( dp[l][r] != 0 ) return dp[ l ][ r ] ;
    ll ans = a[i].first*Abs(a[i].second-l)+DP(i+1,l+1,r) ;
    ans = max( a[i].first*Abs(a[i].second-r) + DP(i+1,l,r-1) , ans ) ;
    return dp[l][r] = ans ;
}
void solve(){
    cin >> n ; for( int i = 1 ; i <= n ; i ++ ){
        cin >> a[ i ].first ; a[ i ].second = i ;
    }
    sort( a+1 , a+1+n ) ; reverse( a+1 , a+1+n ) ;
    cout << DP( 1 , 1 , n ) << "\n" ;
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}

```

