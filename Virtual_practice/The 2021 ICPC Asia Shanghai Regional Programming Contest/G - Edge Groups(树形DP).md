
数错组数了，应该是 $n!!$ 而不是排列组合关系

队友写的

```cpp

#include <bits/stdc++.h>
#pragma GCC optimize(2)
using namespace std;
#define ldb long double
#define ll long long
#define ull unsigned long long
#define ill __int128
#define pb push_back
#define PII pair<ll,ll>
#define inf 0x3f3f3f3f
#define inff 0x3f3f3f3f3f3f3f3f
#define mem(a,b) memset(a,b,sizeof a)
#define yes cout<<"YES\n"
#define no cout<<"NO\n"
#define sc(a) scanf("%lf",&a);
const ll N = 1e6+10 ;
const ll mod = 998244353;
const ll esp=1e-6;
bool cmp(ll a,ll b){return a>b;}
ll lowbit(ll x){return x&-x;}
ll gcd(ll a,ll b){return b==0?a:gcd(b,a%b);}
ll lcm(ll a,ll b){return a/gcd(a,b)*b;}
ll exgcd(ll a,ll b,ll &x,ll &y){if(!b){x=1,y=0;return a;}ll d=exgcd(b,a%b,y,x);y-=a/b*x;return d;}
ll ksm(ll a,ll b,ll c){ll sum=1;while(b){if(b&1)sum=sum*a%c;a=a*a%c;b>>=1;}return sum;}
ll addm(ll a,ll b,ll c){return (a%c+b%c)%c;}
ll faddm(ll a,ll b){return (((a%b)+b)%b);}
//inline void print(__int128 x){if(x<0){putchar('-');x=-x;}if(x>9) print(x/10);putchar(x%10+'0');}
//void read(__int128 &x){x=0;int f=1;char ch=getchar();while (!isdigit(ch)){if (ch=='-')f=-1;ch=getchar();}while(isdigit(ch)){x=x*10+ch-48;ch=getchar();}x*=f;}
ll fact[N],infact[N];void init(ll n){fact[0]=1;for(int i=1;i<=n;i++) fact[i]=(fact[i-1]*i)%mod;infact[n]=ksm(fact[n],mod-2,mod);for(int i=n-1;i>=0;i--) infact[i]=infact[i+1]*(i+1)%mod;}ll cmb( ll a , ll b ){if(b>a) return 0 ;return (((fact[a]*infact[a-b])%mod)*infact[b])%mod ;}
ll h[N],e[N*2],ne[N*2],w[N*2],idx;void add(ll a,ll b,ll c){e[idx]=b,ne[idx]=h[a],h[a]=idx,w[idx++]=c;}
//ll fa[N],siz[N];ll ifind(ll x){return x==fa[x]?x:fa[x]=ifind(fa[x]);}
ll n;
ll dp[N];//������i����ڵ�Ϊ�����ķ�����
ll flag[N];//�����������Ҫ�ڵ�
ll cmb_sum[N];
void dfs(ll x,ll fa)
{
    ll siz=0;
    ll cnt=0;
    dp[x]=1;
    for(int i=h[x];i!=-1;i=ne[i])
    {
        ll v=e[i];
        if(v==fa) continue;
        dfs(v,x);
        siz++;
        if(flag[v]) cnt++;//Ҫ���Ҽ���
    }
    if(siz==0) return;
    ll d=siz-cnt;
    if(d%2==0)//ʣ��ڵ����
    {
        for(int i=h[x];i!=-1;i=ne[i])
        {
            ll v=e[i];
            if(v==fa) continue;
            dp[x]*=dp[v];
            dp[x]%=mod;
        }
        dp[x]*=cmb_sum[d/2];
        dp[x]%=mod;
    }
    else{
        flag[x]=1;
        for(int i=h[x];i!=-1;i=ne[i])
        {
            ll v=e[i];
            if(v==fa) continue;
            dp[x]*=dp[v];
            dp[x]%=mod;
        }
        dp[x]*=d;
        dp[x]%=mod;
        dp[x]*=cmb_sum[(d-1)/2];
        dp[x]%=mod;
    }

}

void solve()
{
    mem(h,-1);
    cin>>n;
    for(int i=1;i<n;i++)
    {
        ll u,v;
        cin>>u>>v;
        add(u,v,1);
        add(v,u,1);
    }
    cmb_sum[0]=1;
    for(ll i=1;i<=100000;i++)
    {
        ll now=i*2-1;
        cmb_sum[i]=cmb_sum[i-1]*now;
        cmb_sum[i]%=mod;
    }
    dfs(1,-1);
    cout<<dp[1]<<"\n";
}
int main(){
    ios::sync_with_stdio(0); cin.tie(0);cout.tie(0);
    ll tt = 1;
   // freopen("input.txt", "r", stdin);
   // cin >> tt ;
    init(400000);
    while( tt-- ) solve() ;
    return 0 ;
}
//130321 361
```
