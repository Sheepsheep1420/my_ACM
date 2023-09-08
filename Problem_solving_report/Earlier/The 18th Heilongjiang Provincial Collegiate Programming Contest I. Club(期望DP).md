## The 18th Heilongjiang Provincial Collegiate Programming Contest I. Club(期望DP)

#### 题意:

​		有 $n$ 个社团，$m$ 种奖章，保证 $m \le n$。 每个社团可以分得一种奖章。一个人会随机地在每一个社团中参加活动，并获得该社团的奖章。问人工干预奖章的分配后，每一个人集齐所有奖章的最小的期望次数是多少。

#### 分析：

​		所有类型的奖章应该平摊给每个社团，则奖章可以分为两类，一类分给了 $\lceil\frac{n}{m}\rceil$ 个社团，一类分给了 $\lceil\frac{n}{m}\rceil-1$ 个社团。设两类奖章的数量分别为 $A,B$ 种，被选到的概率分别为 $p,q$ 。 则 $A=(n-1)\%m+1$，$B=m-A$，$p=\frac{\lceil\frac{n}{m}\rceil}{n}$，$q=\frac{\lceil\frac{n}{m}\rceil-1}{n}$。0

​		定义 $DP[i][j]$ 为第一类奖章差 $i$ 种集齐 ， 第二类奖章差 $j$ 种集齐时，还需要进行游戏次数的期望值。有初始值 $DP[0][0]=0$，可得
$$
DP[i][j] = (1-p-q)*DP[i][j]+p*DP[i-1][j]+q*DP[i][j-1]+1
$$
即
$$
DP[i][j] =  \frac{p}{p+q}DP[i-1][j]+\frac{q}{p+q}DP[i][j-1]+\frac{1}{p+q}
$$

#### 代码：



