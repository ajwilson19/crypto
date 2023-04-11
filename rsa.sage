# size is the exponent determining the size of p and q.  If size == 100, key_gen randomly generates two primes in the neighborhood of 2^100
# The function generates n and d.  You may hard-code an e value. 17 will work. 
# The function returns (n,e,d)
def key_gen(size):
    p = random_prime(2^(size + 1), False, 2^(size - 1))
    q = random_prime(2^(size + 1), False, 2^(size - 1))
    n = p * q
    e = 17
    m = (p - 1) * (q - 1)
    d = inverse_mod(e, m)
    return n, e, d


# plain_text is a string, the message to be encrypted.
# e, n have been generated by key_gen and form the public key.
# Transforms plain_text to an integer using txt_to_num (see below).
# Returns c, the ciphertext encrypted using RSA algorithm.
def encrypt(plain_text, e, n):
    m = txt_to_num(plain_text)
    chunk_length = len(str(n))
    c = ""
    while(len(str(m))):
        m = str(m)
        end = len(m)
        chunk = str(m)[0:chunk_length-1]
        m = m[chunk_length-1:end]
        pt = sage.rings.integer.Integer(chunk)
        ct = pt.powermod(e, n)
        c += str(ct) + " "   
    return c 


# d has been generated by key_gen, c by encrypt.
# Decrypts c into an integer using the RSA algorithm.
# Transforms the integer output into a string using num_to_txt (see below)
# Returns p, the plaintext 

def decrypt(c, d, n):

    chunks = c.split()
    m = ""
    for i in chunks:
        ct = sage.rings.integer.Integer(i)
        pt = ct.powermod(d, n)
        m += str(pt)
    return num_to_text(sage.rings.integer.Integer(m))  


    


# transforms msg_in to a base 256 integer which it then returns
def txt_to_num(msg_in):
    m = list(map(ord,msg_in))
    num = ZZ(m,256)
    return num


# transforms a base 256 integer to a string which it then returns
def num_to_text(num_in):
    msg_idx = num_in.digits(256)
    m = map(chr,msg_idx)
    m = ''.join(m)
    return m


