## LuoTianyi and the Floating Islands (Hard Version)

#### 题意：	

​		给定一棵 $n$ 个结点的树，现在有 $k(k\le n)$ 个结点上有人。

​		一个结点是好的当且仅当这个点到所有人的距离之和最小。

​		求在这 $n$ 个点中随机取 $k$ 个点时，好的结点的期望个数，对 $10^9+7$ 取模。

#### 分析：

​		称有人的结点为**关键点**。满足$min_u\sum_idis(u,i)$性质的点为$k$个关键点的重心，即点$u$是$good$的当且仅在$u$作为根是，每个子树中关键点的数量均$\leq\lfloor\frac{k}{2}\rfloor$。

​		所以枚举每个点$u$，然后计算有多少关键点的分布方式使得$u$满足这个性质。

​		因为关键点数$＞\lfloor\frac{k}{2}\rfloor$的子树至多有一个，所以可以用总情况减去不合法情况，于是点$u$贡献的不合法的情况数有式子

：
$$
\sum_{(u,v)∈E}\sum_{i=\lfloor\frac{k}{2}\rfloor+1}^k\begin{pmatrix}siz_u\\i\end{pmatrix}\begin{pmatrix}n-siz_u\\k-i\end{pmatrix}
$$
这样的复杂度是$O(n^2)$的。

因为这个式子只跟$siz_v$有关，不妨假设：
$$
L=\lfloor\frac{k}{2}\rfloor+1\\
f_x = \sum_{i=L}^{k}\begin{pmatrix}x\\i\end{pmatrix}\begin{pmatrix}n-x\\k-i\end{pmatrix}
$$
考虑$O(n)$递推$f_{1...n}$。
$$
f_{x+1}-f_x =
\sum_{i=L}^k

\begin{pmatrix}x+1\\i\end{pmatrix}\begin{pmatrix}n-x-1\\k-i\end{pmatrix}
-
\begin{pmatrix}x\\i\end{pmatrix}\begin{pmatrix}n-x\\k-i\end{pmatrix} \\
=
\sum_{i=L}^k
\begin{pmatrix}x\\i-1\end{pmatrix}\begin{pmatrix}n-x-1\\k-i\end{pmatrix} + 
\begin{pmatrix}x\\i\end{pmatrix}\begin{pmatrix}n-x-1\\k-i\end{pmatrix} -
\begin{pmatrix}x\\i\end{pmatrix}\begin{pmatrix}n-x\\k-i\end{pmatrix} \\

= 
\sum_{i=L}^k
\begin{pmatrix}x\\i-1\end{pmatrix}\begin{pmatrix}n-x-1\\k-i\end{pmatrix} -
\begin{pmatrix}x\\i\end{pmatrix}\begin{pmatrix}n-x-1\\k-i-1\end{pmatrix} \\

\\
= 
\sum_{i=L-1}^{k-1} \begin{pmatrix}x\\i\end{pmatrix}\begin{pmatrix}n-x-1\\k-i-1\end{pmatrix} - 
\sum_{i=L}^{k-1} \begin{pmatrix}x\\i\end{pmatrix}\begin{pmatrix}n-x-1\\k-i-1\end{pmatrix} \\
= \begin{pmatrix}x\\\lfloor\frac{k}{2}\rfloor\end{pmatrix}\begin{pmatrix}n-x-1\\k-\lfloor\frac{k}{2}\rfloor-1\end{pmatrix}
$$

#### tag:

组合数递推公式
$$
\begin{pmatrix}n\\m\end{pmatrix} = 
\begin{pmatrix}n-1\\m-1\end{pmatrix} + 
\begin{pmatrix}n-1\\m\end{pmatrix}
$$
若 $m<0$或$m>n$则为$0$

#### 代码：

```cpp
#include<bits/stdc++.h>
using namespace std ;
#define ll long long
#define double long double
const ll N = 1e6+9 ;
const ll INF = 1e17 ;
const ll mod = 1e9+7 ;
//const double pi = acos(-1) ;
const double eps = 1e-7 ;
ll gcd( ll a , ll b ){ return a == 0 ? b : gcd( b%a , a ) ; }
ll lcm( ll a , ll b ){ return (a/gcd(a,b))*b ; }
ll Abs( ll x ){ return x < 0 ? -x : x ; }
ll ksm( ll a , ll b ){
    ll res = 1 ; a %= mod ;
    while( b ){
        if(b&1) (res*=a)%=mod ;
        (a*=a)%=mod ;
        b >>= 1 ;
    }
    return res ;
}
ll fac[ N ] , inv[ N ] , f[ N ] ;
ll cmb( ll a , ll b ){
    if( b > a ) return 0 ;
    ll res = (fac[a]*inv[a-b])%mod ;
    res = (res*inv[b])%mod ;
    return res ;
}
ll n , k , siz[ N ] ;
vector<ll>g[ N ] ;
void dfs( ll x , ll fa ){
    siz[ x ] = 1 ;
    for( auto u : g[x] ){
        if( u == fa ) continue ;
        dfs( u , x );
        siz[ x ] += siz[ u ] ;
    }
}
void solve(){
    fac[ 0 ] = inv[ 0 ] = 1 ;
    for( ll i = 1 ; i < N ; i ++ ) fac[ i ] = (fac[i-1]*i)%mod ;
    inv[ N-1 ] = ksm( fac[N-1] , mod-2 ) ;
    for( ll i = N-2 ; i >= 1 ; i -- ) inv[ i ] = (inv[i+1]*(i+1))%mod ;

    //cout << cmb( 5 , 2 ) << "\n" ;

    cin >> n >> k ;

    for( int i = 1 ; i < N ; i ++ ){
        f[ i ] = (f[i-1] + (cmb(i-1,k/2)*cmb(n-i,k-k/2-1))%mod )%mod ;
    }

    for( int i = 1 ; i < n ; i ++ ){
        ll x , y ; cin >> x >> y ;
        g[ x ].push_back( y ) ; g[ y ].push_back( x ) ;
    }

    dfs( 1 , 0 ) ;

    ll ans = 0 ;
    for( int i = 1 ; i <= n ; i ++ ){
        (ans += cmb(n,k))%=mod ;
        for( auto u : g[i] ){
            ll sz = siz[u] ; if( sz > siz[i] ) sz = n-siz[i] ;
            ans = (( ans - f[sz] )%mod + mod )%mod ;
        }
    }

    cout << (ans*ksm(cmb(n,k),mod-2))%mod << "\n" ;

}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}



```

