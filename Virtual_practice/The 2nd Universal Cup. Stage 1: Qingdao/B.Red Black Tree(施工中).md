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
WA了，明天改
```cpp
#include<bits/stdc++.h>
using namespace std;
#define ll long long
#define double long double
const ll N = 2e6+9 ;
const ll INF = 1e18 ;
ll gcd( ll a , ll b ){ return a == 0 ? b : gcd(b%a,a) ; }
int n , m , q ;
vector<pair<int,ll>>g[ N ] ;
bool is_red[ N ] ;
ll cost[ N ] , deep[ N ] , f[ N ][ 30 ] , dis[ N ] ;
bool cmp( int a , int b ){
    return cost[ a ] > cost[ b ] ;
}
void dfs( ll x , ll fa ){
    f[ x ][ 0 ] = fa ;
    if( is_red[x] ) cost[x] = 0 ;

    for( auto u : g[x] ){
        if( u.first == fa ) continue ;
        cost[ u.first ] = cost[ x ] + u.second ;
        deep[ u.first ] = deep[ x ] + u.second ;
        dis[ u.first ] = dis[ x ] + 1 ;
        dfs( u.first , x ) ;
    }

    for( int i = 1 ; i <= 25 ; i ++ ) f[ x ][ i ] = f[ f[x][i-1] ][i-1] ;
}
int LCA( int x , int y ){
    //cout << "1 x=" << x << " y=" << y << "\n" ;
    if( dis[ x ] < dis[ y ] ) swap( x , y ) ;
    for( int i = 25 ; i >= 0 ; i -- ) if( dis[ f[x][i] ] >= dis[ y ] ){
        x = f[x][i] ;
    }
    //cout << "2 x=" << x << " y=" << y << "\n" ;
    if( x == y ) return x ;
    for( int i = 25 ; i >= 0 ; i -- ) if( f[x][i] != f[y][i] ){
        x = f[x][i] ; y = f[y][i] ;
    }
    //cout << "3 x=" << x << " y=" << y << "\n" ;
    return f[x][0] ;
}
void solve(){
    cin >> n >> m >> q ; //点，红色点数，询问次数
    for( int i = 1 , x ; i <= m ; i ++ ){
        cin >> x ; is_red[ x ] = 1 ;
    }
    for( int i = 1 ; i < n ; i ++ ){
        ll x , y , w ; cin >> x >> y >> w ;
        g[ x ].push_back( {y,w} ) ;
        g[ y ].push_back( {x,w} ) ;
    }

    dfs( 1 , 0 ) ;

    //cout << "f_2 : " ;
    //for( int i = 1 ; i <= n ; i ++ ) cout << f[ i ][2] << " " ; cout << "\n" ;

    while( q-- ){
        ll k ; cin >> k ;
        ll lca = -1 , ans = INF , maxdeep ;
        vector<ll>v(k+1) ;
        for( int i = 1 ; i <= k ; i ++ ) cin >> v[ i ] ;
        sort( v.begin()+1 , v.end() , cmp ) ;

        //cout << " v : " ;
        //for( int i = 1 ; i <= k ; i ++ ) cout << v[i] << " " ; cout << "\n" ;
        //cout << " cost : " ;
        //for( int i = 1 ; i <= k ; i ++ ) cout << cost[v[i]] << " " ; cout << "\n" ;

        for( int i = 1 ; i <= k ; i ++ ){
            if( i == 1 ){ lca = v[i] ; ans = cost[ v[i] ] ; maxdeep = deep[ v[i] ] ; continue ; }
            else{
                ll res = max( cost[ v[i] ] , maxdeep-deep[lca] ) ;
                //cout << " i=" << i << " lca=" << lca << " res=" << res << "\n" ;
                ans = min( ans , res ) ;
            }
            lca = LCA(lca,v[i]) ;
        }
        ans = min( ans , maxdeep-deep[lca] ) ;
        cout << ans << "\n" ;
    }
    for( int i = 1 ; i <= n ; i ++ ){
        g[i].clear() ;
        cost[ i ] = deep[ i ] = dis[i] = 0 ; is_red[ i ] = 0 ;
    }
}
int main(){
    ios::sync_with_stdio(0); cin.tie(0);cout.tie(0);
    ll tt = 1 ; cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}
//B = sqrt(n*n/m)
/*
2

12 2 4
1 9
1 2 1
2 3 4
3 4 3
3 5 2
2 6 2
6 7 1
6 8 2
2 9 5
9 10 2
9 11 3
1 12 10
3 3 7 8
4 4 5 7 8
4 7 8 10 11
3 4 5 12

3 2 3
1 2
1 2 1
1 3 1
1 1
2 1 2
3 1 2 3
*/
```
