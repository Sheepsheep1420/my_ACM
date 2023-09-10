### 题意：

宝宝刚在后院发现了一棵有 n 个顶点和（n - 1）条带权边的有根树。在这些顶点中，有 m 个是红色的，其余的是黑色的。树的根是顶点 1，且它是一个红色顶点。

我们定义红色顶点的代价为 0，黑色顶点的代价为该顶点与其最近的红色祖先之间的距离。

回顾一下：
- 在树上，路径的长度是该路径上所有边的权重之和。
- 两个顶点之间的距离是树上从一个顶点到另一个顶点的最短路径的长度。
- 如果顶点 u 在从顶点 v 到树根（问题中的顶点 1）的最短路径上，那么顶点 u 是顶点 v 的祖先。

宝宝感到无聊，决定和这棵树玩 q 次游戏。在第 i 次游戏中，宝宝会在树上选择 ki 个顶点 vi,1, vi,2,...,vi,ki，并尝试通过改变至多一个顶点，将这 ki 个顶点的最大代价最小化。

请注意：
- 宝宝可以自由地将任意一个顶点（不一定是 ki 个顶点中的顶点）改变为红色顶点。
- 所有的 q 次游戏是独立的。也就是说，每次游戏中宝宝玩的树始终是初始给定的树，而不是在上一次游戏中通过改变至多一个顶点而修改的树。

请帮助宝宝计算在每个游戏中，通过将至多一个顶点改变为红色顶点后，这 ki 个给定顶点的最大代价的最小可能值。

### 思路：


![image](https://github.com/Sheepsheep1420/my_ACM/assets/97673966/40d3f45a-b70e-4a83-aa75-fd3820ddfcb1)



### 代码：


```cpp
#include<bits/stdc++.h>
using namespace std;
#define ll long long
#define double long double
const ll N = 2e6+9 ;
const ll INF = 1e18 ;
ll gcd( ll a , ll b ){ return a == 0 ? b : gcd(b%a,a) ; }
ll n , m , q , tot ;
vector<pair<ll,ll>>g[ N ] ;
ll cost[ N ] , deep[ N ] , f[ N ][ 30 ] , dis[ N ] ;
bool cmp( ll a , ll b ){
    return cost[ a ] > cost[ b ] ;
}
void dfs( ll x , ll fa ){
    f[ x ][ 0 ] = fa ;
    for( int i = 1 ; i <= 25 ; i ++ ) f[ x ][ i ] = f[ f[x][i-1] ][i-1] ;
    
    dis[ x ] = dis[ fa ] + 1 ;
    for( auto u : g[x] ){
        if( u.first == fa ) continue ;
        cost[ u.first ] = min( cost[u.first] , cost[ x ] + u.second ) ;
        deep[ u.first ] = deep[ x ] + u.second ;
        dfs( u.first , x ) ;
    }
}
ll LCA( ll x , ll y ){
    if( x == y ) return x ;
    if( dis[ x ] < dis[ y ] ) swap( x , y ) ;
    for( int i = 25 ; i >= 0 ; i -- ) if( dis[ f[x][i] ] >= dis[ y ] ){
        x = f[x][i] ;
    }
    if( x == y ) return x ;
    for( int i = 25 ; i >= 0 ; i -- ) if( f[x][i] != f[y][i] ){
        x = f[x][i] ; y = f[y][i] ;
    }
    return f[x][0] ;
}
void solve(){
    cin >> n >> m >> q ; //点，红色点数，询问次数

    for( int i = 1 ; i <= n ; i ++ ){
        g[i].clear() ;
        deep[ i ] = dis[i] = 0 ; cost[ i ] = INF ;
    }

    for( int i = 1 , x ; i <= m ; i ++ ){
        cin >> x ; cost[ x ] = 0 ;
    }
    for( int i = 1 ; i < n ; i ++ ){
        ll x , y , w ; cin >> x >> y >> w ;
        g[ x ].push_back( {y,w} ) ;
        g[ y ].push_back( {x,w} ) ;
    }

    dfs( 1 , 0 ) ;

    while( q-- ){
        ll k ; cin >> k ;

        vector<ll>v(k+1,0) ;
        for( int i = 0 ; i < k ; i ++ ) cin >> v[ i ] ;
        sort( v.begin() , v.end()-1 , cmp ) ;

        ll lca = v[0] , ans = cost[ v[1] ] , maxdeep = deep[ v[0] ] ;

        for( int i = 1 ; i < k ; i ++ ){

            lca = LCA(lca,v[i]) ;
            maxdeep = max( maxdeep , deep[ v[i] ] ) ;

            ll res = max( cost[ v[i+1] ] , maxdeep-deep[lca] ) ;
            //cout << "i=" << i+1 << " res=" << res << " lca=" << lca << "\n" ;
            ans = min( ans , res ) ;

        }
        cout << ans << "\n" ;
    }
}
int main(){
    ios::sync_with_stdio(0); cin.tie(0);cout.tie(0);
    ll tt = 1 ; cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}
```

### 警示：

把LCA的f数组预处理错了，导致wa了好久

正确写法：

```cpp
void dfs( ll x , ll fa ){
    f[ x ][ 0 ] = fa ;
    for( int i = 1 ; i <= 25 ; i ++ ) f[ x ][ i ] = f[ f[x][i-1] ][i-1] ;
    
    ...
    for( auto u : g[x] ){
        ...
        dfs( u.first , x ) ;
    }
}
```

错误写法：

```cpp
void dfs( ll x , ll fa ){
    f[ x ][ 0 ] = fa ;    
    ...
    for( auto u : g[x] ){
        ...
        dfs( u.first , x ) ;
    }
    for( int i = 1 ; i <= 25 ; i ++ ) f[ x ][ i ] = f[ f[x][i-1] ][i-1] ;
}
```
