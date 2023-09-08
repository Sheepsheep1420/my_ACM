## AtCoder Beginner Contest 156 E.Roaming(组合数学)

#### 题意：

​	有$n$个房间，每个房间初始有一个人，每次移动可将一个人移到另一个房间，求$k$次移动后$n$个房间的状态数。

#### 分析：

​	枚举$0$的个数$m$，经过$k$次操作后，$0$的个数最多是$min(n-1,k)$，此时有$C_{n}^{m}$种情况。而每一种情况中，$0$的个数为$m$，则可转化为在$n$个数中插入$n-m-1$块板，即有$C_{n-1}^{n-m-1}$种情况。

​	所以当$0$的个数为$m$时，情况数是$C_{n}^{m}*C_{n-1}^{n-m-1}$

​	总答案为
$$
\sum_{m=1}^{min(k,n-1)} C_{n}^{m}*C_{n-1}^{n-m-1}
$$

#### 代码：

```c++
#include <bits/stdc++.h>
using namespace std;
#define ll long long
const ll N = 2e5+9 ;
const ll mod = 1e9+7 ;
const ll INF = 1e18 ;
ll ksm( ll a , ll b ){
    ll res = 1 ;
    while( b ){
        if( b&1 ) (res*=a)%=mod ;
        (a*=a)%=mod ;
        b >>= 1 ;
    }
    return res ;
}
ll f[ N ] , inv[ N ] ;
ll cmb( ll a , ll b ){
    return (((f[a]*inv[a-b])%mod)*inv[b])%mod ;
}
void solve(){
    ll n , k ; cin >> n >> k ;
    k = min( k , n-1 ) ;
    ll ans = 0 ;
    for( int i = 0 ; i <= k ; i ++ ){
        ( ans += (cmb( n , i )*cmb( n-1 , n-i-1 ))%mod )%=mod;
    }
    cout << ans << "\n" ;
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;

    f[ 0 ] = 1 ;
    for( ll i = 1 ; i < N ; i ++ ) f[ i ] = (f[i-1]*i)%mod ;
    inv[ N-1 ] = ksm( f[N-1] , mod-2 ) ;
    for( ll i = N-2 ; i >= 0 ; i -- ) inv[ i ] = (inv[ i+1 ]*(i+1))%mod ;

    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}
```

