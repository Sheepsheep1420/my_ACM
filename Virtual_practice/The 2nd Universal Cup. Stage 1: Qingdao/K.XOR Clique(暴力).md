题意：

思路：

代码：
队友写的

```cpp
#include<bits/stdc++.h>
using namespace std;
#define ull unsigned long long
#define ll long long
#define pb push_back
#define PII pair<ll,ll>
#define inf 0x3f3f3f3f
#define inff 0x3f3f3f3f3f3f3f3f
#define mem(a,b) memset(a,b,sizeof a)
#define endl '\n'
const ll N=1e6+5;
const double eps=1e-6;
const ll mod=998244353;
const double pi=3.141592653589;
const double ol=0.57721566490153286060651209;
ll n;
ll a[N];
void solve()
{
    cin>>n;
    for(int i=1;i<=n;i++) cin>>a[i];
    map<ll,ll> dl;
    ll max1=0;
    for(int i=1;i<=n;i++)
    {
        ll x;x=a[i];
        ll len=0;
        while(x)
        {
            len++;
            x/=2;
        }
        dl[len]++;
        max1=max(dl[len],max1);
    }
    cout<<max1<<endl;
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ;
    cin>>tt;
    while(tt--) solve();
}

```
