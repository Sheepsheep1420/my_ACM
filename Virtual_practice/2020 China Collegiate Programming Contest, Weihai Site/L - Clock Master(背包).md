分组背包做，队友好聪明

```cpp
#include<bits/stdc++.h>
#define ll long long
using namespace std;
const ll N = 3e4+9 ;
ll prim[ N ] , idx = 0 ;
ll vis[ N ] ;
void init()
{
    for(ll i = 2;i< N;i++)
    {
        if(vis[i]==0)
        {
            prim[++idx]=i;
        }
        for(ll j=1;j<=idx&& i*prim[j]<N;j++)
        {
            vis[i*prim[j]]=1;
            if(i%prim[j]==0) break;
        }
    }
}
long double f[ N ] ;
long double lg[ N ] ;
ll last[N];
void solve()
{
    ll n ; cin >> n ;
    cout << fixed << setprecision(9) << f[n] << "\n" ;
}
int main()
{
    ios::sync_with_stdio(0);cin.tie(0);cout.tie(0);

    init() ;
    for( int i = 1 ; i <= 30000 ; i ++ ) lg[ i ] = log( i ) ;

    for( int i = 1 ; i <= idx ; i ++ )
        for( int j = N-1 ; j >= 0 ; j -- )
        {
            for( ll now = prim[i] ; now < N-1 ; now *= prim[i] )
            {
                if( j >= now ) f[ j ] = max( f[j] , f[j-now]+lg[now] ) ;
            }
        }

    ll tt = 1 ; cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}


```
