```cpp
#include<bits/stdc++.h>
#define ll long long
using namespace std;
const ll N = 2e5+9 ;
struct node
{
    int x , y , w ;
}e[N];
vector<pair<int,int>>g[N] ;
bool tag[N] ;
int up[N] , down[N] , f[N] , in[N] , deep[N] , sum ;
void dfs( int x , int idx )
{
    for( auto u : g[x] )
    {
        if( u.second == idx ) continue ;
        if( deep[u.first] )
        {
            if( deep[u.first] < deep[x] ) //返祖边
            {
                up[x] ++ ;
            }
            else
            {
                down[x] ++ ;
            }
            continue ;
        }
        deep[ u.first ] = deep[x]+1 ;
        dfs( u.first , u.second ) ;
        f[x] += f[u.first] ;
        in[x] += in[u.first] ;
    }
    f[x] -= down[x] ;
    f[x] += up[x] ;
    if( f[x] == 0 && ( (((in[x]-1)/2)&1) || (((sum-in[x]-1)/2)&1) ) ) tag[idx] = 1 ;
}
void solve( int n , int m )
{
    //把每条边标一下看哪个不能删
    ll tot = 0 , ans = 0 ;
    for( int i = 1 ; i <= m ; i ++ )
    {
        cin >> e[i].x >> e[i].y >> e[i].w ;
        g[ e[i].x ].push_back( {e[i].y,i} ) ;
        g[ e[i].y ].push_back( {e[i].x,i} ) ;
        in[ e[i].x ] ++ ; in[ e[i].y ] ++ ; sum += 2 ;
        tot += e[i].w ;
    }

    deep[1] = 1 ;
    dfs( 1 , 0 ) ;

    for( int i = 1 ; i <= m ; i ++ ) if( !tag[i] )
    {
        ans = max( ans , tot-e[i].w ) ;
    }
    cout << ans << "\n" ;
}
int main()
{
    ios::sync_with_stdio(0);cin.tie(0);cout.tie(0);
    //偶数边是总和
    //奇数边删一条，避开造成两个连通块有其中之一为奇数边的割边
    int n , m ; cin >> n >> m ;
    if( m&1 ) solve( n , m ) ;
    else
    {
        ll ans = 0 ;
        for( int i = 1 ; i <= m ; i ++ )
        {
            int x , y , w ; cin >> x >> y >> w ; ans += w ;
        }
        cout << ans << "\n" ;
    }
    return 0 ;
}

```
