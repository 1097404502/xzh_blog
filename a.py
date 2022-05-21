def Palindrome(s,l,r):
    while l >= 0 and r < len(s):
        if s[l] == s[r]:
            l -= 1
            r += 1
    return s[l+1:r]

s = "babad"
n = len(s)
for i in range(n):
    s1 = Palindrome(s,i,i)
    s2 = Palindrome(s,i,i+1)
    if len(s1) >= len(s2):
        res = s1
    else:
        res = s2
print(res)