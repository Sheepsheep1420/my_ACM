队友写的

因为由最长上升子序列改成最长不下降子序列少改了等号没过样例卡了1h

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
bool cmp(ll a,ll b){return a>b;}
ll lowbit(ll x){return x&-x;}
ll Abs(ll x){return x>0?x:-x;}
ll gcd(ll a,ll b){return b==0?a:gcd(b,a%b);}
ll lcm(ll a,ll b){return a/gcd(a,b)*b;}
ll exgcd(ll a,ll b,ll &x,ll &y){if(!b){x=1,y=0;return a;}ll d=exgcd(b,a%b,y,x);y-=a/b*x;return d;}
ll ksm(ll a,ll b,ll c){ll sum=1;while(b){if(b&1)sum=sum*a%c;a=a*a%c;b>>=1;}return sum;}
//ll h[N],e[N*2],ne[N*2],w[N*2],idx;void add(ll a,ll b,ll c){e[idx]=b,ne[idx]=h[a],h[a]=idx,w[idx++]=c;}
//ll fa[N],siz[N];ll ifind(ll x){return x==fa[x]?x:fa[x]=ifind(fa[x]);}
ll n,m;
double x[N];
double y[N];
int check(double w)
{
    vector<double>b(n+1,0);
    vector<double>q(n+1,0);
    for(int i=0;i<n;i++)
    {
        b[i]=y[i+1]-x[i+1]*w;
        //cout<<b[i]<<' ';
    }//cout<<endl;
    ll len=0;
    for(int i = 0; i < n; i ++)
    {
        int l = 0, r = len;
        while(l < r)
        {
            int mid = l + r + 1 >> 1;
            if(q[mid] <= b[i]) l = mid;
            else r = mid - 1;
        }

        q[r + 1] = b[i];
        if(r + 1 > len) len ++;
    }
    //cout<<len<<endl;
    return len;
}
void solve()
{
    cin>>n>>m;
    for(int i=1;i<=n;i++)
    {
        cin>>x[i]>>y[i];
    }
   // cout<<check(0.5)<<endl;
    double r=1e9+5;
    double l=-r;

    ll cnt=100;
    while(cnt--)
    {
        double mid=(l+r)/2.0;
        //cout<<l<<' '<<r<<' '<<mid<<endl;
        if(check(mid)<m)
        {
            r=mid;
        }
        else
        {
            l=mid;
        }
    }
    cout<<fixed<<setprecision(8)<<l<<endl;
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ;
    //cin>>tt;
    while(tt--) solve();
}
```
