#!/usr/bin/env python
import sys
def _m(a):
    if len(a)==0:
        return "."
    else:
        return ",".join(a)
def _strs(a):
    r = []
    for i in a:
        r.append(str(i))
    return r
def _mf(a):
    if len(a)==0:
        return "."
    else:
        return ",".join(_strs(a))
class ORM:
    def __init__(self,d): #d is line.split("\t")
        self.chr = d[0][1]
        self.start = int(d[0][2])
        self.end = int(d[0][3])
        self.name = d[0][4]
        self.feat = []
        self.fpos = []
        self.fval = []
        if len(d)>1:
            for f in d[1:]:
                if f[0]=="Nucleotide":
                    self.feat.append("N")
                    self.fpos.append(int(f[2])-self.start)
                    self.fval.append(int(f[3]))
                elif f[0]=="Segment":
                    self.feat.append("S")
                    self.fpos.append(int(f[2])-self.start)
                    self.fval.append(int(f[3])-int(f[2]))
    def bedstring(self):
        bed6 = "%s\t%d\t%d\t%s\t.\t0"%(self.chr,self.start,self.end,self.name)
        featStr = _m(self.feat)
        fposStr = _mf(self.fpos)
        fvalStr = _mf(self.fval)
        feat = "%s\t%d\t%s\t%s\t%s"% (bed6,len(self.feat),featStr,fposStr,fvalStr)
        return feat

def iterOrm(f):
    for d in _iterOrmLines(f):
        yield ORM(d)
    return

def _iterOrmLines(f): # iterate orm file
    buf = []
    for line in f:
        a = line.split("\t")
        if a[0]=="Fiber" and len(buf)!=0:
            yield buf
            buf = [a]
        else:
            buf.append(a)
    if len(buf) > 0:
        yield buf
    raise StopIteration
    return

def main():
    f = open(sys.argv[1],"r")
    for a in iterOrm(f):
        print a.bedstring()
if __name__=="__main__":
    main()
