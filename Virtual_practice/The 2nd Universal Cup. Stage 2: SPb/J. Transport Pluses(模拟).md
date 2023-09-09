题意：

思路：

代码：

```cpp
#include<bits/stdc++.h>
using namespace std;
#define ll long long
#define double long double
const ll N = 2e6+9 ;
ll gcd( ll a , ll b ){ return a == 0 ? b : gcd(b%a,a) ; }
struct Point{
    ll x , y ;
}a,b,s[ N ];
double dis( Point x , Point y ){
    return sqrtl( (x.x-y.x)*(x.x-y.x)+(x.y-y.y)*(x.y-y.y) ) ;
}
pair<double,Point> s_dis( Point x , Point y ){
    pair<double,Point>res ;
    res.first = dis( x , y ) ; res.second = y ;

    if( dis( x , {y.x,x.y} ) < res.first ){
        res.first = dis( x , {y.x,x.y} ) ;
        res.second = {y.x,x.y} ;
    }

    if( dis( x , {x.x,y.y} ) < res.first ){
        res.first = dis( x , {x.x,y.y} ) ;
        res.second = {x.x,y.y} ;
    }

    return res ;
}
void output( pair<double,vector<pair<ll,Point>>>ans ){
    cout << fixed << setprecision(6) << ans.first << "\n" ;
    cout << ans.second.size() << "\n" ;
    for( auto u : ans.second ) cout << u.first << " " << u.second.x << " " << u.second.y << "\n" ;
}
pair<double,vector<pair<ll,Point>>>ans[3] ;
vector<pair<ll,Point>>tmp;
void solve(){
    ll n ; double t ; cin >> n >> t ;
    cin >> a.x >> a.y >> b.x >> b.y ;
    for( int i = 1 ; i <= n ; i ++ ) cin >> s[ i ].x >> s[ i ].y ;

    for( int i = 0 ; i < 3 ; i ++ ){
        tmp.clear() ;
        tmp.push_back( {0,{0,0}} ) ;
        ans[ i ].first = 1e9 ; ans[ i ].second =  tmp ;
    }

    //不走枢纽
    ans[ 0 ].first = dis( a , b ) ;
    tmp.clear() ;
    tmp.push_back( {0,b} ) ;
    ans[ 0 ].second = tmp ;

    //走一个枢纽
    for( int i = 1 ; i <= n ; i ++ ){
        tmp.clear() ;
        pair<double,Point> res1,res2 ;
        double sum = 0 ;

        res1 = s_dis( a , s[i] ) ; //起点到枢纽的最短距离
        sum += res1.first ; tmp.push_back( {0,res1.second} ) ;

        res2 = s_dis( b , s[i] ) ; //终点到枢纽
        sum += t ; tmp.push_back( {i,res2.second} ) ; //枢纽上的跳跃
        sum += res2.first ; tmp.push_back( {0,b} ) ;

        if( sum < ans[1].first ){
            ans[1].first = sum ;
            ans[1].second = tmp ;
        }
    }

    //走两个枢纽
    for( int i = 1 ; i <= n ; i ++ )
        for( int j = 1 ; j <= n ; j ++ ) if( i != j ){
            tmp.clear() ;
            pair<double,Point> res1,res2 ;
            double sum = 0 ;
            Point mix = {s[i].x,s[j].y} ;

            res1 = s_dis( a , s[i] ) ; //起点到枢纽1的最短距离
            sum += res1.first ; tmp.push_back( {0,res1.second} ) ;

            sum += t ; tmp.push_back( {i,mix} ) ; //枢纽1到枢纽2

            res2 = s_dis( b , s[j] ) ; //终点到枢纽2
            sum += t ; tmp.push_back( {j,res2.second} ) ; //枢纽上的跳跃
            sum += res2.first ; tmp.push_back( {0,b} ) ;

            if( sum < ans[2].first ){
                ans[2].first = sum ;
                ans[2].second = tmp ;
            }
    }

    if( ans[0].first < ans[1].first && ans[0].first < ans[2].first ) output( ans[0] ) ;
    else if( ans[1].first < ans[2].first ) output( ans[1] ) ;
    else output( ans[2] ) ;



}
int main(){
    ios::sync_with_stdio(0); cin.tie(0);cout.tie(0);
    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}
//B = sqrt(n*n/m)

```
