# GSS1 - Can you answer these queries I(序列静态区间最大子段和)

## 题意

​		给定长度为 $n$ 的序列 $a_1, a_2,\cdots,a_n$。现在有 $m$ 次询问操作，每次给定 $l_i,r_i$，查询 $[l_i,r_i]$ 区间内的最大子段和。$|a_i|\le 15007$，$1\le n\le 5\times 10^4$。

## 分析	

- ### step1·如何维护最大子段和？	

​		当两个已知最大**子段和**的区间 $A$，$B$ 合并成更大的区间 $C$ 时，最大子段和有三种情况：

一、$C$ 区间的最大子段和为 $A$ 区间的最大子段和。

![image-20230630134635931](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230630134635931.png)

二、$C$ 区间的最大子段和为 $B$ 区间的最大子段和。

![image-20230630134809586](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230630134809586.png)

三、$C$ 区间的最大子段和为 $A区间的最大后缀和+B区间的最大前缀和$。

![image-20230630135024819](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230630135024819.png)

- ### step2·如何维护最大后缀和？

​		当两个已知最大**后缀和**的区间 $A$，$B$ 合并成更大的区间 $C$ 时，最大后缀和有两种情况：

一、$C$ 区间的最大后缀和为 $B$ 区间的最大后缀和。

![image-20230630135501438](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230630135501438.png)

二、$C$ 区间的最大后缀和为 $B区间的区间和+A区间的最大后缀和$。

![image-20230630140139842](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230630140139842.png)

- ### step3·如何维护最大前缀和？

  ​		当两个已知最大**前缀和**的区间 $A$，$B$ 合并成更大的区间 $C$ 时，最大前缀和有两种情况：

  一、$C$ 区间的最大前缀和为 $A$ 区间的最大前缀和。

![image-20230630140354294](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230630140354294.png)

二、$C$ 区间的最大前缀和为 $A区间的区间和+B区间的最大前缀和$。

![image-20230630140457956](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230630140457956.png)

所以，我们用线段树维护区间的四个信息：最大子段和、最大前缀和、最大后缀和、区间和即可。

### 代码

```cpp
#include<bits/stdc++.h>
using namespace std ;
#define ll long long
#define double long double
const ll N = 2e5+9 ;
const ll INF = 1e17 ;
const ll mod = 998244353 ;
//const double pi = acos(-1) ;
const double eps = 1e-7 ;
ll gcd( ll a , ll b ){ return a == 0 ? b : gcd( b%a , a ) ; }
ll lcm( ll a , ll b ){ return (a/gcd(a,b))*b ; }
ll Abs( ll x ){ return x < 0 ? -x : x ; }
ll Max( ll a , ll b ){ return a > b ? a : b ; }
ll Min( ll a , ll b ){ return a < b ? a : b ; }
struct node{
    ll sum , max_sum , max_pre , max_suf ;
}t[ N<<2 ];
ll n ;
void push_up( ll p ){
    t[p].sum = t[p<<1].sum + t[p<<1|1].sum ;
    t[p].max_sum = Max( t[p<<1].max_suf + t[p<<1|1].max_pre , Max( t[p<<1].max_sum , t[p<<1|1].max_sum ) ) ;
    t[p].max_suf = Max( t[p<<1|1].max_suf , t[p<<1|1].sum + t[p<<1].max_suf ) ;
    t[p].max_pre = Max( t[p<<1].max_pre , t[p<<1].sum + t[p<<1|1].max_pre ) ;
}
void build( ll l , ll r , ll p ){
    if( l == r ){
        cin >> t[ p ].sum ;
        t[ p ].max_sum = t[ p ].max_pre = t[ p ].max_suf = t[ p ].sum ;
        return ;
    }
    ll mid = l+r >> 1 ;
    build( l , mid , p<<1 ) ; build( mid+1 , r , p<<1|1 ) ;
    push_up( p ) ;
}
node query( ll l , ll r , ll L = 1 , ll R = n , ll p = 1 ){
    if( l <= L && R <= r ){
        return t[ p ] ;
    }
    ll MID = L+R >> 1 ;
    if( r <= MID ){
        return query( l , r , L , MID , p<<1 ) ;
    }
    if( l > MID ){
        return query( l , r , MID+1 , R , p<<1|1 ) ;
    }
    node lson , rson , res ;
    lson = query( l , r , L , MID , p<<1 ) ;
    rson = query( l , r , MID+1 , R , p<<1|1 ) ;

    res.sum = lson.sum + rson.sum ;
    res.max_sum = Max( lson.max_suf + rson.max_pre , Max( lson.max_sum , rson.max_sum ) ) ;
    res.max_suf = Max( rson.max_suf , rson.sum + lson.max_suf ) ;
    res.max_pre = Max( lson.max_pre , lson.sum + rson.max_pre ) ;

    return res ;
}
void solve(){
    cin >> n ;
    build( 1 , n , 1 ) ;
    ll q ; cin >> q ;
    while( q-- ){
        ll l , r ; cin >> l >> r ;
        node res = query( l , r ) ;
        cout << res.max_sum << "\n" ;
    }
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}

```

# F2. Omsk Metro (hard version)(树上静态区间最大子段和)