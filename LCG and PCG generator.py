import os
import time
#LCG code
class LCGPseudoRandomGenerator:
    def __init__(self, a=48271, c=0, m=2**31-1, seed=None): #C++11 minstd_rand
        self.a = a
        self.c = c
        self.m = m
        if seed is None:
            self.x0 = int(os.getpid() + time.time())
        else:
            self.x0 = seed

        self.x_prev = (self.a * self.x0 + self.c) % self.m

    def generate_number(self, num_range=None):
         self.x_prev = (self.a * self.x_prev + self.c) % self.m
         if num_range is None:
             return self.x_prev
         else:
             return int((self.x_prev/(self.m - 1)) * (num_range[1]-num_range[0])+num_range[0])

#PCG code
class PCGPseudoRandomGenerator:
    def __init__(self, a=6364136223846793005, c=1442695040888963407, m=2**64, seed=None):
        self.a = a
        self.c = c
        self.m = m
        self.mask64 = m-1

        if seed is None:
            self.state = int((os.getpid() << 32) ^ int(time.time() * 1000)) & self.mask64
        else:
            self.state = seed & self.mask64

        self.state = (self.a * self.state + self.c) & self.mask64
        
    def generate_number(self, num_range=None):
        self.state = (self.a * self.state + self.c) & self.mask64
        rot = self.state >> 59
        xorshifted = (((self.state >> 18) ^ self.state) >> 27) & 0xFFFFFFFF
        pcg_output = ((xorshifted >> rot) | (xorshifted << ((-rot)&31))) & 0xFFFFFFFF
        
        if num_range is None:
            return pcg_output 
        else:
             scaled = (pcg_output / 0xFFFFFFFF) * (num_range[1] - num_range[0]) + num_range[0]
             return int(scaled)   
    
#QCG Code
class QCGPseudoRandomGenerator:
    def __init__(self, a=17, b=3, c=7, m=2**31-1, seed=None):

        self.a=a
        self.b=b
        self.c=c
        self.m=m

        if seed is None:
            self.x0=int(os.getpid()+time.time())
        else: 
            self.x0=seed
        self.x_prev=(self.a*(self.x0**2)+self.b*self.x0+self.c)%self.m
    
    def generate_number(self, num_range=None):
        self.x_prev=(self.a*(self.x_prev**2)+self.b*self.x_prev+self.c)%self.m

        if num_range is None:
            return self.x_prev
        else:
            scaled = (self.x_prev/(self.m-1))*(num_range[1]-num_range[0])+num_range[0]
            return int(scaled)    

lcg = LCGPseudoRandomGenerator()
print("Printing LCG values")
print(lcg.generate_number([0,100]))
print(lcg.generate_number([0,100]))
print(lcg.generate_number([0,100]))
print(lcg.generate_number([0,100]))
print(lcg.generate_number([0,100]))

pcg = PCGPseudoRandomGenerator()
print("Printing PCG values")
print(pcg.generate_number([0,100]))
print(pcg.generate_number([0,100]))
print(pcg.generate_number([0,100]))
print(pcg.generate_number([0,100]))
print(pcg.generate_number([0,100]))

qcg = QCGPseudoRandomGenerator()
print("Printing QCG values")
print(qcg.generate_number([0,100]))
print(qcg.generate_number([0,100]))
print(qcg.generate_number([0,100]))
print(qcg.generate_number([0,100]))
print(qcg.generate_number([0,100]))
