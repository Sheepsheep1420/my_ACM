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
bool cmp(ll a,ll b){return a>b;}
ll lowbit(ll x){return x&-x;}
ll Abs(ll x){return x>0?x:-x;}
ll gcd(ll a,ll b){return b==0?a:gcd(b,a%b);}
ll lcm(ll a,ll b){return a/gcd(a,b)*b;}
ll exgcd(ll a,ll b,ll &x,ll &y){if(!b){x=1,y=0;return a;}ll d=exgcd(b,a%b,y,x);y-=a/b*x;return d;}
ll ksm(ll a,ll b,ll c){ll sum=1;while(b){if(b&1)sum=sum*a%c;a=a*a%c;b>>=1;}return sum;}
//ll h[N],e[N*2],ne[N*2],w[N*2],idx;void add(ll a,ll b,ll c){e[idx]=b,ne[idx]=h[a],h[a]=idx,w[idx++]=c;}
//ll fa[N],siz[N];ll ifind(ll x){return x==fa[x]?x:fa[x]=ifind(fa[x]);}
void solve()
{
    ll p,q;cin>>p>>q;
    ll temp=gcd(p,q);
    p/=temp;q/=temp;
    double t=(double)p/(double)q;
    ll tempp=sqrtl(p*p-4*q*q);
    if(tempp*tempp!=p*p-4*q*q)
    {
        cout<<0<<' '<<0<<endl;return;
    }
   // cout<<"tempp"<<tempp<<endl;
    ll res1=p+tempp;
    ll res2=q*2;
    ll gc=gcd(res1,res2);
    //cout<<res1<<' '<<res2<<endl;
    res1/=gc;
    res2/=gc;
    cout<<res1<<' '<<res2<<endl;return ;
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ;
    cin>>tt;
    while(tt--) solve();
}

```
