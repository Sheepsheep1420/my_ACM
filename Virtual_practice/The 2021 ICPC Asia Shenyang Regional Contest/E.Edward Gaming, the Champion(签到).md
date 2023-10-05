```cpp
#include<bits/stdc++.h>
using namespace std ;
int main()
{
    string s ; cin >> s ;
    int n = s.size() , ans = 0 ;
    for( int i = 0 ; i < n-5+1 ; i ++ )
    {
        if( s[i] == 'e' && s[i+1] == 'd' && s[i+2] == 'g' && s[i+3] == 'n' && s[i+4] == 'b' ) ans ++ ;
    }
    cout << ans << "\n" ;
    return 0 ;
}

```
