
l1 = []
with open('out.txt', 'r') as f:
    l = f.readlines()
    for line in l:
        l1.append(line) 
l2 = []
with open("in.txt", 'r') as f:
    l = f.readlines()
    for line in l:
        l2.append(line) 

for i in range(50):
    if l1[i] != l2[i]:
        print('not matching')
        print(l1[i])
        print(l2[i])