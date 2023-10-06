有技巧的模拟，队友好聪明

对群聊分组就好做了

```cpp

#include<bits/stdc++.h>
#define ll long long
using namespace std;
const ll N = 2e5+9 ;
struct node{
    int op , x ; //op:操作，x:学生
};
vector<node>g[N] ;
ll ans[ N ] , Begin[ N ] ;
int main()
{
    ios::sync_with_stdio(0);cin.tie(0);cout.tie(0);
    int n , m , s ; // 群，学生，操作数
    cin >> n >> m >> s ;

    for( int i = 1 ; i <= s ; i ++ )
    {
        int op , x , y ; //操作，学生，群
        cin >> op >> x >> y ;
        g[y].push_back( {op,x} ) ;
        if( op == 3 ) ans[ x ] -- ;
    }

    for( int i = 1 ; i <= n ; i ++ )
    {
        vector<ll>sum(g[i].size()+5,0) ;
        int idx = 0 ;
        set<int>st;
        for( auto u : g[i] )
        {
           idx ++ ;
           sum[idx] = sum[idx-1] ;
           if( u.op == 1 ) //入群
           {
               Begin[u.x] = idx ; st.insert(u.x);
           }
           if( u.op == 2 )
           {
               ans[ u.x ] += sum[ idx ] - sum[ Begin[u.x]-1 ] ;
               Begin[ u.x ] = 0 ;
               st.erase( st.lower_bound(u.x) ) ;
           }
           if( u.op == 3 )
           {
               sum[idx] ++ ;
           }
        }
        for( auto u : st )
        {
            ans[ u ] += sum[idx] - sum[ Begin[u]-1 ] ;
            Begin[ u ] = 0 ;
        }

    }

    for( int i = 1 ; i <= m ; i ++ ) cout << ans[i] << "\n" ;

    return 0 ;
}
```
