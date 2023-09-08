## Codeforces Round 625 D. Navigation System

#### 题意：

​        给出 $2\le n\le2\cdot 10^5$ 个节点，$2\le m\le2\cdot 10^5$ 条边的有向图，路径 $p_1,\cdots,p_k$，路径中没有重复元素，边 $(p_i,p_{i+1})$ 总是存在。

定义 $s=p_1,t=p_k$ 。

​        有一个导航系统，若当前在节点 $u$，会构造一条从 $u$ 到 $t$ 的最短路径（这种路径可能不止一条，但导航系统只会选其中一条），设导航系统规划的下一个节点为 $w$，实际行走的下一个节点为 $v$ 。

- $w=v$ 不会触发重构。
- $w\neq v$ 会触发重构。

实际行走路线为 $p$，求可能的最少重构次数和最多重构次数。

#### 分析： 

​        定义 $d_i$ 为从 $i$ 点到 $t$ 点的最短路的长度。当我们从 $v$ 点移动到 $u$ 点时:

​		如果 $d_u > d_v-1$ ，则重构一定会发生

​		如果  $d_u=d_v-1$ ，但同时还存在与 $v$ 相连的点 $w≠u$ ，使得 $d_w=d_v-1$ ，此时重构可能发生

​		否则重构一定不发生

#### 代码：

```cpp
#include <bits/stdc++.h>
#define ll long long
using namespace std;
const ll N = 1e6+9;
void solve(){
   ll n , m ; cin >> n >> m ;
   vector<ll>dis(n+1,-1) ;
   vector<vector<ll>>g(n+1),G(n+1) ;
   for( int i = 1 ; i <= m ; i ++ ){
        ll x , y ; cin >> x >> y ;
        g[ y ].push_back( x ) ;
        G[ x ].push_back( y ) ;
   }
   ll num , s , t ; cin >> num ;
   vector<ll>p(num+1) ;
   for( int i = 1 ; i <= num ; i ++ ) cin >> p[ i ] ;
   s = p[1] ; t = p[num] ;

   dis[ t ] = 0 ;
   queue<ll>q; q.push(t) ;
   while( !q.empty() ){
        ll x = q.front() ; q.pop() ;
        for( auto u : g[x] ){
            if( dis[u] != -1 ) continue ;
            dis[ u ] = dis[x]+1 ;
            q.push( u ) ;
        }
   }
   ll ans1 = 0 , ans2 = 0 ;
   for( int i = 2 ; i <= num ; i ++ ){
        ll u = p[i] , v = p[i-1] ;
        if( dis[u] > dis[v]-1 ) ans1 ++ , ans2 ++ ;
        else{
            for( auto x : G[v] ){
                if( x != u && dis[x]+1 == dis[v] ){
                    ans2 ++ ; break ;
                }
            }
        }
   }
   cout << ans1 << " " << ans2 << "\n" ;
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}

```

