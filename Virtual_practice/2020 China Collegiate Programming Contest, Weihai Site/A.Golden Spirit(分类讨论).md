特判没仔细想，大伙都默认它是对的，删掉就过了。

队友写的

```cpp

#include<bits/stdc++.h>
#define ll long long
using namespace std;
void solve()
{
    ll n,x,t;

    cin>>n>>x>>t;
    ll ans=4ll*n*t;
    ll u=9223372036854775708;
        //第一种是我等4
    ll t1=2ll*n*t-2ll*t;
    t1=x-t1;
    t1=max(0ll,t1);
    u=min(t1,u);

    ll t2=(2ll*n*t);//我来之前休息了t2
    ll uu=x-t2;
    uu=max(0ll,uu);
    uu+=t;
    u=min(uu,u);
    cout<<ans+u<<"\n";

}
int main()
{
    ios::sync_with_stdio(0);cin.tie(0);cout.tie(0);
    ll tt=1;
    cin>>tt;
    while(tt--) solve();
}
```
