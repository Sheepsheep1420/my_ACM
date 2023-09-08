二分最小值
```cpp
#include<bits/stdc++.h>
using namespace std;
#define ll long long
const ll N = 2e6+9 ;
ll n , m ;
bool check( ll mid ){
    ll need = 0 ;
    ll cnt1 = m ;
    ll cnt0 = n-m ;
    for( int i = 1 ; i <= n ; i += mid+1 ){
        ll now = min( n-i+1 , mid ) ;
        if( cnt1 <= now ) return 1 ;
        cnt1 -= now ;
        if( i+now-1 < n ) cnt0 -- ;
        if( cnt0 < 0 ) return 0 ;
    }
    if( cnt1 > 0 ) return 0 ;
    return 1 ;
}
void solve(){
    cin >> n >> m ;
    if( m == 0 ){
        cout << m << " " << m << "\n" ; return ;
    }
    ll l = 1 , r = m , mid , ans = 0 ;
    while( l <= r ){
        mid = l+r >> 1 ;
        if( check( mid ) ){
            r = mid-1 ; ans = mid ;
        }
        else l = mid+1 ;
    }
    cout << m << " " << ans << "\n" ;
}
int main(){
    ios::sync_with_stdio(0); cin.tie(0);cout.tie(0);
    ll tt = 1 ; cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}
```
