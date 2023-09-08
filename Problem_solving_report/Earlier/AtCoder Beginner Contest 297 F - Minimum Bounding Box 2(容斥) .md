# F - Minimum Bounding Box 2

在 **n*m** 的矩形框里随机撒下 **k** 个点，然后找到一个矩形 **a** 框住这 **k** 个点，代价 **c** 是 **a** 的面积。问 **c** 的期望



枚举矩形框大小，看这个大小下面有多少种符合条件的情况，然后乘上代价。这些累加起来以后，最后除一下总的情况数 **C(n*m，k)** 



算每个矩形框大小固定的时候有多少种符合条件的情况,正着算去重不太容易

试试反着算



![](C:\Users\杨阳\AppData\Roaming\Tencent\QQ\Temp\0QNQ(5FI$[$Q(R)T8C5W0@T.png)

当矩形为 **C0** 时 ，若 **k** 个点在 **C1,C2,C3,C4**  中取 ， 则均为不合法的情况

设 **f( c )** 为在矩阵 **c** 中选择 **k** 个点的情况数量 

则
$$
\bigcup_{i=1}^{4}f(C_i) = \sum_{i=1}^{4}f(C_i) - \sum_{1\leq i<j\leq 4}f(C_i \cap C_j) + \sum_{ 1 \leq i < j < k \leq 4 }f( C_i \cap C_j \cap C_k ) - f(C_1\cap C_2 \cap C_3 \cap C_4 )
$$


该在容斥专题好好收拾一下我的lj写法了......

```C++
#include<bits/stdc++.h>
using namespace std ;
#define ll long long
#define double long double
const ll N = 1e6+9 ;
const ll INF = 1e17 ;
const ll mod = 998244353 ;
//const double pi = acos(-1) ;
const double eps = 1e-9 ;
ll gcd( ll a , ll b ){ return a == 0 ? b : gcd( b%a , a ) ; }
ll lcm( ll a , ll b ){ return (a/gcd(a,b))*b ; }
ll ksm( ll a , ll b ){
    ll res = 1 ;
    while( b ){
        if( b&1 ) ( res*=a )%=mod ;
        ( a*=a ) %= mod ;
        b >>= 1 ;
    }
    return res ;
}
ll f[ N ] , inv[ N ] , n , m , k ;
ll cmb( ll a , ll b ){
    return (((f[a]*inv[a-b])%mod)*inv[b])%mod ;
}
void solve(){
    cin >> n >> m >> k ;

    f[ 0 ] = 1 ;
    for( ll i = 1 ; i <= n*m ; i ++ ) f[ i ] = (f[i-1]*i)%mod ;
    inv[ n*m ] = ksm( f[n*m] , mod-2 ) ;
    for( ll i = n*m-1 ; i >= 0 ; i -- ) inv[ i ] = (inv[ i+1 ]*(i+1))%mod ;


    if( k == 1 ){
        cout << "1\n" ; return ;
    }

    ll ans = 0 ;
    ll M = ksm( cmb(n*m,k) , mod-2 ) ;

    for( ll i = 1 ; i <= n ; i ++ ){
        for( ll j = 1 ; j <= m ; j ++ ){
            if( i*j < k ) continue ;

            ll res = cmb( i*j , k ) , del = 0 ;

            // +C1
            // +C3
            if( (i-1)*j >= k ) del = (del+cmb( (i-1)*j , k )*2)%mod ;
            // +C2
            // +C4
            if( i*(j-1) >= k ) del = (del+cmb( i*(j-1) , k )*2)%mod ;
            // -C1C2
            // -C1C4
            // -C2C3
            // -C3C4
            if( (i-1)*(j-1) >= k ) del = ((del-cmb( (i-1)*(j-1) , k )*4)%mod + mod)%mod ;
            // -C1C3
            if( (i-2)*j >= k ) del = ((del-cmb( (i-2)*j , k ))%mod + mod)%mod ;
            // -C2C4
            if( i*(j-2) >= k ) del = ((del-cmb( i*(j-2) , k ))%mod + mod)%mod ;
            // +C1C2C3
            // +C1C3C4
            if( (i-2)*(j-1) >= k ) del = ((del+cmb( (i-2)*(j-1) , k )*2)%mod + mod)%mod ;
            // +C2C3C4
            // +C1C2C4
            if( (i-1)*(j-2) >= k ) del = ((del+cmb( (i-1)*(j-2) , k )*2)%mod + mod)%mod ;
            // -C1C2C3C4
            if( (i-2)*(j-2) >= k ) del = ((del-cmb( (i-2)*(j-2) , k ))%mod + mod)%mod ;

            res = ( (res-del)%mod + mod )%mod ;

            ll num = (n-i+1)*(m-j+1) ;

            res = (res*num)%mod ;
            res = (res*i*j)%mod ;
            //res = (res*M)%mod ;

            ans = (ans+res)%mod ;
        }
    }

    ans = (ans*M)%mod ;
    cout << ans << "\n" ;

}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}

```

