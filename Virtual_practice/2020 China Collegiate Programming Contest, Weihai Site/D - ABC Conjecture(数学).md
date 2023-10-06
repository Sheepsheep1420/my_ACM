把1e6以内的素数判掉以后要有平方也只能是一个质因子了

队友好聪明

```cpp
#include<bits/stdc++.h>
#define ll long long
using namespace std;
const ll N = 2e6+9 ;
bitset<N> vis;
ll prim[N],idx=0;
void init()
{
    for(ll i=2;i<N;i++)
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
void solve()
{

    ll n ; cin >> n ;
    for( int i = 1 ; i <= idx ; i ++ )
    {
        if( n%(prim[i]*prim[i]) == 0 )
        {
            cout << "yes\n" ; return ;
        }
        while( n%prim[i] == 0 ) n /= prim[i] ;
    }

    ll s = sqrtl(n) ;
    if( s*s == n && n != 1 ) cout << "yes\n" ;
    else cout << "no\n" ;
}
int main()
{
    ios::sync_with_stdio(0);cin.tie(0);cout.tie(0);
    ll tt=1;
    init();
    cin>>tt;
    while(tt--) solve();
    return 0 ;
}
```
