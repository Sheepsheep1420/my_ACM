被卡常了。。。。
slt和结构体里写队列常数很大

队友写的
```cpp
#include<bits/stdc++.h>
#pragma GCC optimize(2)
#define mem(a,b) memset(a,b,sizeof a)
#define inff 0x3f3f3f3f
#define ll int
using namespace std ;
const int N=2e5+4;
int vis[30][N];

int n,m;
int cnt=0;
int h[N],e[N*2],ne[N*2],w[N*2],idx;void add(ll a,ll b,ll c){e[idx]=b,ne[idx]=h[a],h[a]=idx,w[idx++]=c;}

int a[N];
int head=1;
int endd=0;

int bfs(int x,int start)//第x位
{
    head=1;endd=0;
    int cnt1=0,cnt0=0;
    a[++endd] = start ;
    vis[x][start]=1;//1是1 2是0
    while(head<=endd)
    {
        int now=a[head++];
        if(vis[x][now]==1) cnt1++;
        else if(vis[x][now]==2) cnt0++;
        for(int i=h[now];i!=-1;i=ne[i])
        {
           // cnt++;
            int v=e[i];
            int itsecond=((w[i]>>x)&1);
            if(vis[x][v])
            {
                if(vis[x][now]!=vis[x][v] && itsecond==0 )
                {
                    return inff;

                }
                if(vis[x][now]==vis[x][v] && itsecond==1 )
                {
                    return inff;
                }
            }
            else
            {
                if(vis[x][now]==1)
                {
                    if(itsecond==1) vis[x][v]=2;
                    else vis[x][v]=1;
                    a[++endd]=v;
                }
                else
                {
                    if(itsecond==1) vis[x][v]=1;
                    else vis[x][v]=2;
                    a[++endd]=v;
                }
            }
        }
    }
    if(cnt1<cnt0) return cnt1 ;
    else return cnt0 ;
}
int main()
{
   ios::sync_with_stdio(0);cin.tie(0);cout.tie(0);
   cin>>n>>m;
   for(int j=1;j<=n;j++) h[j]=-1;
   for(int i=1;i<=m;i++)
   {
       int u,v,x;
       cin>>u>>v>>x;
       add(u,v,x);
       add(v,u,x);
   }
   long long  ans=0;
   for(int i=0;i<=29;i++)
   {
       int now=0;
       for(int j=1;j<=n;j++)
       {
           if(vis[i][j]) continue;
           int d=bfs(i,j);
           if(d==inff)
           {
               cout<<"-1\n";
               return 0;
           }
           now+=d;
       }
       ans+=(1ll<<i)*now;
   }
   cout<<ans<<"\n";
   return 0;
}


```
