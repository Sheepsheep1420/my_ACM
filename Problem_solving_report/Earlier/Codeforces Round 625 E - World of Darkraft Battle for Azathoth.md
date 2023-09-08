## Codeforces Round 625 E - World of Darkraft: Battle for Azathoth(数据结构)

#### 题意：

​		给定一系列有代价的装备，第一种提供 $x$ 值，代价是 $cx$，第二种提供 $y$ 值，代价是 $cy$ ，每种装备买一个。给出一些怪兽，如果怪兽的 $x_i$ 和 $y_i$ 都小于选定的 $x$ 和 $y$ ，那么会有 $z_i$ 的奖励。最大化收益。$1\leq n\leq 2\times 10^5$ 。

#### 分析：

​		将$x$和$y$都升序排序，怪兽按照$x$升序排序。枚举选择$x_i$，若只考虑$x$属性，当前的$x_i$相比于$x_{i-1}$,能够打过的怪兽编号一定是递增的。假设此时选择 $i$ 号提供 $y$ 值的装备，获得的价值是$f(i)$， 在怪兽被考虑进可击败集的时候，对于当前这只怪兽而言，$y$ 属性可以击败它的装备是一段区间，给这个区间加上这只怪兽的贡献值。(提供 $y$ 属性的装备，最初价值$f(i)=-y_i$)，然后对于每一个$x_i$，答案就是$max(f(i))-cx_i$

#### 在pair里面lower_bound会出事

#### 代码：

```cpp
#include <bits/stdc++.h>
#define ll long long
using namespace std;
const ll N = 2e6+9;
const ll INF = 1e18 ;
ll t[ N<<2 ] , lazy[ N<<2 ] , n ;
vector<pair<ll,ll>>a,b;
vector<pair<ll,pair<ll,ll>>>c;
vector<ll>d;
void pushup( ll p ){
    t[ p ] = max( t[p<<1] , t[p<<1|1] ) ; return ;
}
void pushdown( ll p ){
    if( lazy[p] == 0 ) return ;
    lazy[p<<1] += lazy[p] ;
    lazy[p<<1|1] += lazy[p] ;
    t[p<<1] += lazy[p] ;
    t[p<<1|1] += lazy[p] ;
    lazy[p] = 0 ;
    return ;
}
void update( ll L , ll R , ll val , ll l = 1 , ll r = n , ll p = 1 ){
    if( L <= l && r <= R ){
        lazy[ p ] += val ; t[ p ] += val ;
        return ;
    }
    pushdown( p ) ;
    ll mid = l+r >> 1 ;
    if( L <= mid ) update( L , R , val , l , mid , p<<1 ) ;
    if( R > mid ) update( L , R , val , mid+1 , r , p<<1|1 ) ;
    pushup( p ) ;
}
void build( ll l = 1 , ll r = n , ll p = 1 ){
    if( l == r ){
        t[ p ] = -b[l].second ;
        return ;
    }
    ll mid = l+r >> 1 ;
    build( l , mid , p<<1 ) ; build( mid+1 , r , p<<1|1 ) ;
    pushup( p ) ;
    return ;
}
void solve(){
    ll nn , mm , pp ; cin >> nn >> mm >> pp ; n = mm ;
    a.resize(nn+1) ; b.resize(mm+1);
    c.resize(pp+1) ; d.resize(mm+1);
    for( int i = 1 ; i <= nn ; i ++ ){ cin >> a[i].first >> a[i].second ; }
    for( int i = 1 ; i <= mm ; i ++ ){ cin >> b[i].first >> b[i].second ; }
    for( int i = 1 ; i <= pp ; i ++ ){
        cin >> c[i].first >> c[i].second.first >> c[i].second.second ;
    }
    sort( a.begin()+1 , a.end() ) ;
    sort( b.begin()+1 , b.end() ) ;
    sort( c.begin()+1 , c.end() ) ;

    for( int i = 1 ; i <= mm ; i ++ ) d[ i ] = b[i].first ;

    build() ;

    ll ans = -INF , r = 0 ;
    for( int i = 1 ; i <= nn ; i ++ ){
        ll res = -INF ;
        while( r+1 <= pp && c[r+1].first < a[i].first ){
            r++ ;
            ll pos = upper_bound( d.begin()+1 , d.end() , c[r].second.first ) - d.begin() ;
            //if( d[mm].first <= c[r].second.first ) continue ;
            if( pos <= mm && pos >= 1 ){
                update( pos , mm , c[r].second.second ) ;
            }
        }
        res = -a[i].second+t[1] ;
        ans = max( ans , res ) ;
    }
    cout << ans << "\n" ;

}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;

    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}
```

