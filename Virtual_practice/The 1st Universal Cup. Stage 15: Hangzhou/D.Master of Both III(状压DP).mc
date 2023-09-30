```cpp
#include<bits/stdc++.h>
using namespace std ;
#define ll long long
const ll N = 5e6+9 ;
const ll inf = 1e18 ;
const ll mod = 998244353 ;
ll f[ N ] , w[ N ] , n ;
ll del( ll i , ll y ){
    //二进制一共有n位，集体左移y位，会溢出y位
    return ((i>>(n-y))| ((((1<<(n-y))-1)&i)<<y)) ;
}
void output( ll x ){
    for( int i = n-1 ; i >= 0 ; i -- ) cout << ((x>>i)&1) ;
}
void solve(){
    cin >> n ; for( int i = 0 ; i < n ; i ++ ) cin >> w[ i ] ;
    // f[ i ] : S 状态为 i 时全部变成 0 的最小花费
    for( int i = 2 ; i < (1<<n) ; i ++ ) f[ i ] = inf ;

    for( int i = 1 ; i < (1<<n) ; i ++ )
        for( int y = 1 ; y < n ; y ++ ){
            //  ( T ∪ {(x + y) mod n|x ∈ T} )
            ll j = i|del( i , y ) ;
            // 从状态 j 到状态 i 需要补 n-y
            f[ j ] = min( f[ j ] , f[i] + w[n-y] ) ;
        }

    for( int i = (1<<n)-1 ; i >= 0 ; i -- )
        for( int j = 0 ; j < n ; j ++ ) if( (i>>j)&1 ){
            f[ i^(1<<j) ] = min( f[ i^(1<<j) ] , f[ i ] ) ;
    }

    ll ans = 0 ;
    for( ll i = 1 ; i < (1<<n) ; i ++ ) (ans += ((i*(f[i]%mod))%mod))%=mod ;

    cout << ans << "\n" ;

 }
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}
/*
3
2 1 2
001   f : 0
010   f : 1000000000000000000
011   f : 2
100   f : 1000000000000000000
101   f : 1
110   f : 1000000000000000000
111   f : 2


001   f : 0
010   f : 2
011   f : 2
100   f : 1
101   f : 1
110   f : 2
111   f : 2
45

*/
```
