## Educational Codeforces Round 148 D2. Red-Blue Operations (Hard Version)（二分）

#### 题意:

​		有一个长度为 $n$ 的序列 $a$ ，每个位置有一个颜色，初始全为红色。第 $i$ 次操作选择一个位置 $x$，如果为红色就把 $a_x$ 加 $i$ ，并变成蓝色，否则把 $a_x$ 减 $i$ ，并变成红色。

$q$ 次询问给定一个 $k$ ，求恰好 $k$ 次操作后 $a$ 序列最小值的最大值。

#### 分析：

参考博客：[CF1832D 题解 - 2018ljw 的博客 - 洛谷博客 (luogu.com.cn)](https://www.luogu.com.cn/blog/128606/solution-cf1832d2)

##### step1:

-------

​		首先要特判掉 $n=1$ 的情况，这种情况可以直接计算。

##### step2:

-------

​		我们希望每个数最后都被操作奇数次或者不被操作，当 $n\geq2$ 时，这是可以达成的。

##### step3:

-------

​		假设我们要对特定的 $x$ 个数做操作，如何操作最优？

​		对于一个被操作的数字，将其被操作的时间序列 $t_1...t_{2x+1}$ 划分为若干组。$t_{2i}$ 与 $t_{2i-1}$ 分为一组，$t_{2x+1}$ 单成一组。只有最后一组提供正贡献，其余组均为负贡献。

​		为了让负贡献尽可能小，令 $t_{2i}=t_{2i-1}+1$，这样每组负贡献就是 $-1$ 。为了让正贡献尽量大，只需要取最后几次操作即可。同时为了最大化最小值，越小的数分配到的应该越大。

​		这样，我们就可以二分答案了。   

#### step4:

----

​		

​		具体为，先对$a$数组排序，之后二分操作后的最小值，记为 $mid$。

​		$check$ 时:		

​		二分查找到第一个大于等于 $mid$ 的位置的下标，减一后记为 $pos$ 。表示 $[1,pos]$ 都是需要操作的数。

​		如果 $pos=0$，返回 $ture$。

​		如果  $K<pos$ ，说明有的数没法被操作，一定不符合要求，返回 $false$。

​		把最后的 $pos$ 次操作 $t_{pos}...t_{k-pos+1}$ 带来的正贡献分别加到 $[1,pos]$ 位置上。

​		如果 $[1,pos]$ 位置上有数字无法达到 $mid$，返回 $false$。

​		但这要做要遍历一遍$[1,pos]$，有额外的时间消耗，考虑将$t_k$的最后几次操作加到$[1,pos]$上，本质上
$$
a_i = a_i + t_k - i + 1
$$
​		所以我们令 $a_i = a_i-i+1$ ，维护前缀和 $sum[i]$ 与前缀最小值 $minn[i]$。		

​		检查 $[1,pos]$ 位置上是否有数字无法达到 $mid$ 只需检查 $minn[pos]+k$ 是否大于等于 $mid$。

​		再检查现在的数字们能否分担操作 $t_1...t_{k-pos}$ 。

​        如果 $n-pos \geq 2 $ ， 则一定有办法。具体为如果 $k-pos$ 是奇数，那就直接把操作加到 $n$ 位置上，如果是偶数，那就先对 $n-1$ 操作一次，再全部操作到 $n$ 上，这样带来的贡献一定都是正的，不会对结果造成影响。

​		如果 $(k-pos)$ 是奇数，并且 $pos=n$ ，此时根据鸽巢原理 $[1,pos]$ 中一定会有一个数字被操作偶数次，使它无法大于等于 $mid$，所以直接返回$false$。

​		如果 $(k-pos)$ 是奇数，并且 $pos+1=n$ ，此时把剩下的所有操作都放到 $n$ 位置上一定可行，返回$ture$。 

​		否则我们先看看 $[1,pos]$ 中所有数字大于 $mid$ 的部分可不可以抵消掉 $k-pos$ 次操作，一个单位可以抵消 $2$ 次操作，我们可以抵消的次数是 $2*(sum[pos]+k*pos - k*mid )$。

​		如果还有操作没有被抵消掉，需要检查 $a[n]$ 是否可以抵消掉这些负贡献。

​		复杂度 $O(nlogn+qlogV)$ ，$V$ 为答案上界。

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
ll a[ N ] , k[ N ] , sum[ N ] , minn[ N ] , n , q ;
bool check( ll mid , ll K ){
    ll pos = lower_bound( a+1 , a+1+n , mid ) - a - 1 ;
    if( pos == 0 ) return 1 ;
    if( pos > K ) return 0 ;
    if( minn[pos]+K < mid ) return 0 ;

    if( n-pos >= 2 ) return 1 ;
    if( ((K-pos)&1) && n == pos ) return 0 ;
    if( ((K-pos)&1) && n == pos+1 ) return 1 ;

    ll need = K-pos - 2*( sum[pos] + pos*K - pos*mid ) ;
    if( need <= 0 ) return 1 ;
    if( pos == n ) return 0 ;
    need = need - 2*(a[n]-mid) ;
    if( need <= 0 ) return 1 ;
    return 0 ;
}
void solve(){
   cin >> n >> q ;
   for( int i = 1 ; i <= n ; i ++ ) cin >> a[ i ] ;
   for( int i = 1 ; i <= q ; i ++ ) cin >> k[ i ] ;

   sort( a+1 , a+1+n ) ; minn[ 0 ] = INF ;

   for( int i = 1 ; i <= n ; i ++ ) sum[ i ] = sum[i-1] + a[i] - i+1 ;
   for( int i = 1 ; i <= n ; i ++ ) minn[ i ] = min( minn[i-1] , a[i]-i+1 ) ;

   for( int i = 1 ; i <= q ; i ++ ){

        if( n == 1 ){
           cout << a[1] - (k[i]/2) + ((k[i]&1) ? k[i] : 0 ) << "\n" ;
           continue ;
        }

        ll l = 1 , r = 1e17 , mid , ans ;
        while( l <= r ){
            mid = l+r >> 1 ;
            if( check(mid,k[i]) ) l = mid+1 , ans = mid ;
            else r = mid-1 ;
        }
        cout << ans << " " ;
   }
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}

```

