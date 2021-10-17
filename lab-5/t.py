
l1 = set()
with open('out.txt', 'r') as f:
    l = f.readlines()
    for line in l:
        l1.add(line)
l2 = []
with open("in.txt", 'r') as f:
    l = f.readlines()
    for line in l:
        l2.append(line) 

for i in range(50):
    if l2[i] not in l1:
        print("missing item")
        print(l2[i])