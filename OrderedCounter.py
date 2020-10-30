import collections 

class OrderedCounter(collections.Counter, collections.OrderedDict):
    def __repr__(self):
        return "%s(%r)" % (self.__class__.__name__, collections.OrderedDict(self))
