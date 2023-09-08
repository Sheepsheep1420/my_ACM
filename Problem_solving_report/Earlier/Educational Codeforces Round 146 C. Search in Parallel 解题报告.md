## Educational Codeforces Round 146 C. Search in Parallel

#### 题意：

​	我们有$n$个盒子，第$i$个盒子中有无限的颜色为$i$的球，我们有的时候需要查询特定颜色的球。为了查询特定颜色的球，有两个机器人帮助我们。我们可以安排机器人的检查序列$a,b$要求${a}+{b}$是$n$的排列，允许$a$或$b$为空 。$1$号机器人检查一个球的耗时为$s_1$ , $2$ 号机器人检查一个球的耗时为$s_2$ 。两个机器人同时开始从头检查每一个球，直到其中一个机器人找到指定球后结束查询。（若过程中有机器人检查完了整个序列，则机器人停止工作）

若$ s_1 = 2 , s_2 = 3 ,  a = [4,1,5,3,7] , b=[2,6] $，需要查询颜色为$3$的球 

查询过程如下：

第$1$秒末:

![image-20230418113149768](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230418113149768.png)



第$2$秒末:

![image-20230418113259234](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230418113259234.png)

第$3$秒末:

![image-20230418113416142](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230418113416142.png)

第$4$秒末:

![image-20230418113457140](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230418113457140.png)

第$5$秒末:

![image-20230418114211402](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230418114211402.png)

第$6$秒末:

<img src="C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230418115117596.png" alt="image-20230418115117596" style="zoom:100%;" />

第$7$秒末:

<img src="C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230418115147996.png" alt="image-20230418115147996" style="zoom:100%;" />



第$8$秒末:

![image-20230418115420360](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230418115420360.png)



耗时8秒找到颜色为$3$的球。

现在，给出每种颜色的球的查询次数$r_i$ ，我们需要指配$a,b$，使得所有查询结束后总耗时最少。

#### 分析：

​	总代价是
$$
\sum_{i=1}^{n} pre[i]*r[i] 
$$
其中$pre[i]$为第$i$小的前缀和。

要使得总代价最小，即使最大的$r$与最小的$pre$相乘

#### 代码：

```c++
#include <bits/stdc++.h>
using namespace std;
#define ll long long
void solve(){
    ll n , s1 , s2 ;
    cin >> n >> s1 >> s2 ;
    vector<pair<ll,ll>>r(n) ;
    for( int i = 1 ; i <= n ; i ++ ){ cin >> r[i-1].first ; r[i-1].second = i ; }

    sort( r.begin() , r.end() ) ; reverse( r.begin() , r.end() ) ;

    ll r1 = 0 , r2 = 0 ;
    vector<ll>a,b;
    for( int i = 0 ; i < n ; i ++ ){
        if( r1+s1 <= r2+s2 ){
            r1 += s1 ; a.push_back( r[i].second ) ;
        }
        else{
            r2 += s2 ; b.push_back( r[i].second ) ;
        }
    }

    cout << a.size() << " " ; for( auto u : a ) cout << u << " " ; cout << "\n" ;
    cout << b.size() << " " ; for( auto u : b ) cout << u << " " ; cout << "\n" ;

}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}
```

























