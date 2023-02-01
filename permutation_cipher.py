import random

def key_gen():
    alphabet = [chr(i) for i in range (ord('A'), (ord('Z') + 1))]
    random.shuffle(alphabet)
    key = ""
    for i in range(len(alphabet)):
        key += alphabet[i]
    return key    

def encrypt(ch, key):
    lst = [chr(i + ord('A')) for i in range(len(key))]
    lstK = [i for a,i in enumerate(key)]
    enc = {lst[i]: lstK[i] for i in range(len(key))}
    return enc[ch]

def decrypt(ch, key):
    lst = [chr(i + ord('A')) for i in range(len(key))]
    lstK = [i for a,i in enumerate(key)]
    dec = {lstK[i]: lst[i] for i in range(len(key))}
    return dec[ch]

def main():
    key = key_gen()
    print("key:", key)
    pt = input("enter: ").upper()
    ct = ""
    for i in range(len(pt)):
        ct += encrypt(pt[i], key)
    print("cipher text: ", ct)
    pt = ""
    for i in range(len(ct)):
        pt += decrypt(ct[i], key)
    print("plain text: ", pt)

main()