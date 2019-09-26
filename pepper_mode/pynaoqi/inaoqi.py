# This file was automatically generated by SWIG (http://www.swig.org).
# Version 2.0.7
#
# Do not make changes to this file unless you know what you are doing--modify
# the SWIG interface file instead.



from sys import version_info
if version_info >= (2,6,0):
    def swig_import_helper():
        from os.path import dirname
        import imp
        fp = None
        try:
            fp, pathname, description = imp.find_module('_inaoqi', [dirname(__file__)])
        except ImportError:
            import _inaoqi
            return _inaoqi
        if fp is not None:
            try:
                _mod = imp.load_module('_inaoqi', fp, pathname, description)
            finally:
                fp.close()
            return _mod
    _inaoqi = swig_import_helper()
    del swig_import_helper
else:
    import _inaoqi
del version_info
try:
    _swig_property = property
except NameError:
    pass # Python < 2.2 doesn't have 'property'.
def _swig_setattr_nondynamic(self,class_type,name,value,static=1):
    if (name == "thisown"): return self.this.own(value)
    if (name == "this"):
        if type(value).__name__ == 'SwigPyObject':
            self.__dict__[name] = value
            return
    method = class_type.__swig_setmethods__.get(name,None)
    if method: return method(self,value)
    if (not static):
        self.__dict__[name] = value
    else:
        raise AttributeError("You cannot add attributes to %s" % self)

def _swig_setattr(self,class_type,name,value):
    return _swig_setattr_nondynamic(self,class_type,name,value,0)

def _swig_getattr(self,class_type,name):
    if (name == "thisown"): return self.this.own()
    method = class_type.__swig_getmethods__.get(name,None)
    if method: return method(self)
    raise AttributeError(name)

def _swig_repr(self):
    try: strthis = "proxy of " + self.this.__repr__()
    except: strthis = ""
    return "<%s.%s; %s >" % (self.__class__.__module__, self.__class__.__name__, strthis,)

try:
    _object = object
    _newclass = 1
except AttributeError:
    class _object : pass
    _newclass = 0


class SwigPyIterator(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, SwigPyIterator, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, SwigPyIterator, name)
    def __init__(self, *args, **kwargs): raise AttributeError("No constructor defined - class is abstract")
    __repr__ = _swig_repr
    __swig_destroy__ = _inaoqi.delete_SwigPyIterator
    __del__ = lambda self : None;
    def value(self): return _inaoqi.SwigPyIterator_value(self)
    def incr(self, n=1): return _inaoqi.SwigPyIterator_incr(self, n)
    def decr(self, n=1): return _inaoqi.SwigPyIterator_decr(self, n)
    def distance(self, *args): return _inaoqi.SwigPyIterator_distance(self, *args)
    def equal(self, *args): return _inaoqi.SwigPyIterator_equal(self, *args)
    def copy(self): return _inaoqi.SwigPyIterator_copy(self)
    def next(self): return _inaoqi.SwigPyIterator_next(self)
    def __next__(self): return _inaoqi.SwigPyIterator___next__(self)
    def previous(self): return _inaoqi.SwigPyIterator_previous(self)
    def advance(self, *args): return _inaoqi.SwigPyIterator_advance(self, *args)
    def __eq__(self, *args): return _inaoqi.SwigPyIterator___eq__(self, *args)
    def __ne__(self, *args): return _inaoqi.SwigPyIterator___ne__(self, *args)
    def __iadd__(self, *args): return _inaoqi.SwigPyIterator___iadd__(self, *args)
    def __isub__(self, *args): return _inaoqi.SwigPyIterator___isub__(self, *args)
    def __add__(self, *args): return _inaoqi.SwigPyIterator___add__(self, *args)
    def __sub__(self, *args): return _inaoqi.SwigPyIterator___sub__(self, *args)
    def __iter__(self): return self
SwigPyIterator_swigregister = _inaoqi.SwigPyIterator_swigregister
SwigPyIterator_swigregister(SwigPyIterator)

class StringVector(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, StringVector, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, StringVector, name)
    __repr__ = _swig_repr
    def iterator(self): return _inaoqi.StringVector_iterator(self)
    def __iter__(self): return self.iterator()
    def __nonzero__(self): return _inaoqi.StringVector___nonzero__(self)
    def __bool__(self): return _inaoqi.StringVector___bool__(self)
    def __len__(self): return _inaoqi.StringVector___len__(self)
    def pop(self): return _inaoqi.StringVector_pop(self)
    def __getslice__(self, *args): return _inaoqi.StringVector___getslice__(self, *args)
    def __setslice__(self, *args): return _inaoqi.StringVector___setslice__(self, *args)
    def __delslice__(self, *args): return _inaoqi.StringVector___delslice__(self, *args)
    def __delitem__(self, *args): return _inaoqi.StringVector___delitem__(self, *args)
    def __getitem__(self, *args): return _inaoqi.StringVector___getitem__(self, *args)
    def __setitem__(self, *args): return _inaoqi.StringVector___setitem__(self, *args)
    def append(self, *args): return _inaoqi.StringVector_append(self, *args)
    def empty(self): return _inaoqi.StringVector_empty(self)
    def size(self): return _inaoqi.StringVector_size(self)
    def clear(self): return _inaoqi.StringVector_clear(self)
    def swap(self, *args): return _inaoqi.StringVector_swap(self, *args)
    def get_allocator(self): return _inaoqi.StringVector_get_allocator(self)
    def begin(self): return _inaoqi.StringVector_begin(self)
    def end(self): return _inaoqi.StringVector_end(self)
    def rbegin(self): return _inaoqi.StringVector_rbegin(self)
    def rend(self): return _inaoqi.StringVector_rend(self)
    def pop_back(self): return _inaoqi.StringVector_pop_back(self)
    def erase(self, *args): return _inaoqi.StringVector_erase(self, *args)
    def __init__(self, *args): 
        this = _inaoqi.new_StringVector(*args)
        try: self.this.append(this)
        except: self.this = this
    def push_back(self, *args): return _inaoqi.StringVector_push_back(self, *args)
    def front(self): return _inaoqi.StringVector_front(self)
    def back(self): return _inaoqi.StringVector_back(self)
    def assign(self, *args): return _inaoqi.StringVector_assign(self, *args)
    def resize(self, *args): return _inaoqi.StringVector_resize(self, *args)
    def insert(self, *args): return _inaoqi.StringVector_insert(self, *args)
    def reserve(self, *args): return _inaoqi.StringVector_reserve(self, *args)
    def capacity(self): return _inaoqi.StringVector_capacity(self)
    __swig_destroy__ = _inaoqi.delete_StringVector
    __del__ = lambda self : None;
StringVector_swigregister = _inaoqi.StringVector_swigregister
StringVector_swigregister(StringVector)


def _getDefaultSession():
  return _inaoqi._getDefaultSession()
_getDefaultSession = _inaoqi._getDefaultSession
class broker(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, broker, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, broker, name)
    __repr__ = _swig_repr
    def __init__(self, *args): 
        this = _inaoqi.new_broker(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _inaoqi.delete_broker
    __del__ = lambda self : None;
    def shutdown(self): return _inaoqi.broker_shutdown(self)
    def isModulePresent(self, *args): return _inaoqi.broker_isModulePresent(self, *args)
    def getGlobalModuleList(self): return _inaoqi.broker_getGlobalModuleList(self)
    def getALBroker(self): return _inaoqi.broker_getALBroker(self)
    def onDisconnected(self, *args): return _inaoqi.broker_onDisconnected(self, *args)
broker_swigregister = _inaoqi.broker_swigregister
broker_swigregister(broker)

class baseModule(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, baseModule, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, baseModule, name)
    __repr__ = _swig_repr
    def __init__(self): 
        this = _inaoqi.new_baseModule()
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _inaoqi.delete_baseModule
    __del__ = lambda self : None;
    def BIND_PYTHON(self, *args): return _inaoqi.baseModule_BIND_PYTHON(self, *args)
    def _bindWithParam(self, *args): return _inaoqi.baseModule__bindWithParam(self, *args)
    def exit(self): return _inaoqi.baseModule_exit(self)
    def getName(self): return _inaoqi.baseModule_getName(self)
    def getBrokerName(self): return _inaoqi.baseModule_getBrokerName(self)
    def setModuleDescription(self, *args): return _inaoqi.baseModule_setModuleDescription(self, *args)
    def addParam(self, *args): return _inaoqi.baseModule_addParam(self, *args)
    def functionName(self, *args): return _inaoqi.baseModule_functionName(self, *args)
    def autoBind(self, *args): return _inaoqi.baseModule_autoBind(self, *args)
    def _methodMissing0(self, *args): return _inaoqi.baseModule__methodMissing0(self, *args)
    def _methodMissing1(self, *args): return _inaoqi.baseModule__methodMissing1(self, *args)
    def _methodMissing2(self, *args): return _inaoqi.baseModule__methodMissing2(self, *args)
    def _methodMissing3(self, *args): return _inaoqi.baseModule__methodMissing3(self, *args)
    def _methodMissing4(self, *args): return _inaoqi.baseModule__methodMissing4(self, *args)
    def _methodMissing5(self, *args): return _inaoqi.baseModule__methodMissing5(self, *args)
    def _methodMissing6(self, *args): return _inaoqi.baseModule__methodMissing6(self, *args)
    __swig_getmethods__["callPythonMethod0"] = lambda x: _inaoqi.baseModule_callPythonMethod0
    if _newclass:callPythonMethod0 = staticmethod(_inaoqi.baseModule_callPythonMethod0)
    __swig_getmethods__["callPythonMethod1"] = lambda x: _inaoqi.baseModule_callPythonMethod1
    if _newclass:callPythonMethod1 = staticmethod(_inaoqi.baseModule_callPythonMethod1)
    __swig_getmethods__["callPythonMethod2"] = lambda x: _inaoqi.baseModule_callPythonMethod2
    if _newclass:callPythonMethod2 = staticmethod(_inaoqi.baseModule_callPythonMethod2)
    __swig_getmethods__["callPythonMethod3"] = lambda x: _inaoqi.baseModule_callPythonMethod3
    if _newclass:callPythonMethod3 = staticmethod(_inaoqi.baseModule_callPythonMethod3)
    __swig_getmethods__["callPythonMethod4"] = lambda x: _inaoqi.baseModule_callPythonMethod4
    if _newclass:callPythonMethod4 = staticmethod(_inaoqi.baseModule_callPythonMethod4)
    __swig_getmethods__["callPythonMethod5"] = lambda x: _inaoqi.baseModule_callPythonMethod5
    if _newclass:callPythonMethod5 = staticmethod(_inaoqi.baseModule_callPythonMethod5)
    __swig_getmethods__["callPythonMethod6"] = lambda x: _inaoqi.baseModule_callPythonMethod6
    if _newclass:callPythonMethod6 = staticmethod(_inaoqi.baseModule_callPythonMethod6)
    def _fakeMethod0(self): return _inaoqi.baseModule__fakeMethod0(self)
    def _methodMissing(self): return _inaoqi.baseModule__methodMissing(self)
    def version(self): return _inaoqi.baseModule_version(self)
    def registerToBroker(self): return _inaoqi.baseModule_registerToBroker(self)
baseModule_swigregister = _inaoqi.baseModule_swigregister
baseModule_swigregister(baseModule)

def baseModule_callPythonMethod0(*args):
  return _inaoqi.baseModule_callPythonMethod0(*args)
baseModule_callPythonMethod0 = _inaoqi.baseModule_callPythonMethod0

def baseModule_callPythonMethod1(*args):
  return _inaoqi.baseModule_callPythonMethod1(*args)
baseModule_callPythonMethod1 = _inaoqi.baseModule_callPythonMethod1

def baseModule_callPythonMethod2(*args):
  return _inaoqi.baseModule_callPythonMethod2(*args)
baseModule_callPythonMethod2 = _inaoqi.baseModule_callPythonMethod2

def baseModule_callPythonMethod3(*args):
  return _inaoqi.baseModule_callPythonMethod3(*args)
baseModule_callPythonMethod3 = _inaoqi.baseModule_callPythonMethod3

def baseModule_callPythonMethod4(*args):
  return _inaoqi.baseModule_callPythonMethod4(*args)
baseModule_callPythonMethod4 = _inaoqi.baseModule_callPythonMethod4

def baseModule_callPythonMethod5(*args):
  return _inaoqi.baseModule_callPythonMethod5(*args)
baseModule_callPythonMethod5 = _inaoqi.baseModule_callPythonMethod5

def baseModule_callPythonMethod6(*args):
  return _inaoqi.baseModule_callPythonMethod6(*args)
baseModule_callPythonMethod6 = _inaoqi.baseModule_callPythonMethod6

class module(baseModule):
    __swig_setmethods__ = {}
    for _s in [baseModule]: __swig_setmethods__.update(getattr(_s,'__swig_setmethods__',{}))
    __setattr__ = lambda self, name, value: _swig_setattr(self, module, name, value)
    __swig_getmethods__ = {}
    for _s in [baseModule]: __swig_getmethods__.update(getattr(_s,'__swig_getmethods__',{}))
    __getattr__ = lambda self, name: _swig_getattr(self, module, name)
    __repr__ = _swig_repr
    def __init__(self, *args): 
        this = _inaoqi.new_module(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _inaoqi.delete_module
    __del__ = lambda self : None;
module_swigregister = _inaoqi.module_swigregister
module_swigregister(module)

class proxy(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, proxy, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, proxy, name)
    __repr__ = _swig_repr
    def __init__(self, *args): 
        this = _inaoqi.new_proxy(*args)
        try: self.this.append(this)
        except: self.this = this
    def pythonCall(self, *args): return _inaoqi.proxy_pythonCall(self, *args)
    def pythonPCall(self, *args): return _inaoqi.proxy_pythonPCall(self, *args)
    def wait(self, *args): return _inaoqi.proxy_wait(self, *args)
    def stop(self, *args): return _inaoqi.proxy_stop(self, *args)
    def isRunning(self, *args): return _inaoqi.proxy_isRunning(self, *args)
    def session(self): return _inaoqi.proxy_session(self)
    __swig_destroy__ = _inaoqi.delete_proxy
    __del__ = lambda self : None;
proxy_swigregister = _inaoqi.proxy_swigregister
proxy_swigregister(proxy)


def setInstance(*args):
  return _inaoqi.setInstance(*args)
setInstance = _inaoqi.setInstance
class ALMemoryProxyPostHandler(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, ALMemoryProxyPostHandler, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, ALMemoryProxyPostHandler, name)
    def __init__(self, *args, **kwargs): raise AttributeError("No constructor defined")
    __repr__ = _swig_repr
    def addMapping(self, *args): return _inaoqi.ALMemoryProxyPostHandler_addMapping(self, *args)
    def declareEvent(self, *args): return _inaoqi.ALMemoryProxyPostHandler_declareEvent(self, *args)
    def exit(self): return _inaoqi.ALMemoryProxyPostHandler_exit(self)
    def insertData(self, *args): return _inaoqi.ALMemoryProxyPostHandler_insertData(self, *args)
    def insertListData(self, *args): return _inaoqi.ALMemoryProxyPostHandler_insertListData(self, *args)
    def raiseEvent(self, *args): return _inaoqi.ALMemoryProxyPostHandler_raiseEvent(self, *args)
    def raiseMicroEvent(self, *args): return _inaoqi.ALMemoryProxyPostHandler_raiseMicroEvent(self, *args)
    def removeData(self, *args): return _inaoqi.ALMemoryProxyPostHandler_removeData(self, *args)
    def removeEvent(self, *args): return _inaoqi.ALMemoryProxyPostHandler_removeEvent(self, *args)
    def removeMicroEvent(self, *args): return _inaoqi.ALMemoryProxyPostHandler_removeMicroEvent(self, *args)
    def setDescription(self, *args): return _inaoqi.ALMemoryProxyPostHandler_setDescription(self, *args)
    def stop(self, *args): return _inaoqi.ALMemoryProxyPostHandler_stop(self, *args)
    def subscribeToEvent(self, *args): return _inaoqi.ALMemoryProxyPostHandler_subscribeToEvent(self, *args)
    def subscribeToMicroEvent(self, *args): return _inaoqi.ALMemoryProxyPostHandler_subscribeToMicroEvent(self, *args)
    def unregisterModuleReference(self, *args): return _inaoqi.ALMemoryProxyPostHandler_unregisterModuleReference(self, *args)
    def unsubscribeToEvent(self, *args): return _inaoqi.ALMemoryProxyPostHandler_unsubscribeToEvent(self, *args)
    def unsubscribeToMicroEvent(self, *args): return _inaoqi.ALMemoryProxyPostHandler_unsubscribeToMicroEvent(self, *args)
    __swig_destroy__ = _inaoqi.delete_ALMemoryProxyPostHandler
    __del__ = lambda self : None;
ALMemoryProxyPostHandler_swigregister = _inaoqi.ALMemoryProxyPostHandler_swigregister
ALMemoryProxyPostHandler_swigregister(ALMemoryProxyPostHandler)

class ALMemoryProxy(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, ALMemoryProxy, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, ALMemoryProxy, name)
    __repr__ = _swig_repr
    def __init__(self, *args): 
        this = _inaoqi.new_ALMemoryProxy(*args)
        try: self.this.append(this)
        except: self.this = this
    def getGenericProxy(self): return _inaoqi.ALMemoryProxy_getGenericProxy(self)
    def addMapping(self, *args): return _inaoqi.ALMemoryProxy_addMapping(self, *args)
    def declareEvent(self, *args): return _inaoqi.ALMemoryProxy_declareEvent(self, *args)
    def exit(self): return _inaoqi.ALMemoryProxy_exit(self)
    def getBrokerName(self): return _inaoqi.ALMemoryProxy_getBrokerName(self)
    def getData(self, *args): return _inaoqi.ALMemoryProxy_getData(self, *args)
    def getDataList(self, *args): return _inaoqi.ALMemoryProxy_getDataList(self, *args)
    def getDataListName(self): return _inaoqi.ALMemoryProxy_getDataListName(self)
    def getDataOnChange(self, *args): return _inaoqi.ALMemoryProxy_getDataOnChange(self, *args)
    def getDataPtr(self, *args): return _inaoqi.ALMemoryProxy_getDataPtr(self, *args)
    def getDescriptionList(self, *args): return _inaoqi.ALMemoryProxy_getDescriptionList(self, *args)
    def getEventHistory(self, *args): return _inaoqi.ALMemoryProxy_getEventHistory(self, *args)
    def getEventList(self): return _inaoqi.ALMemoryProxy_getEventList(self)
    def getExtractorEvent(self, *args): return _inaoqi.ALMemoryProxy_getExtractorEvent(self, *args)
    def getListData(self, *args): return _inaoqi.ALMemoryProxy_getListData(self, *args)
    def getMethodHelp(self, *args): return _inaoqi.ALMemoryProxy_getMethodHelp(self, *args)
    def getMethodList(self): return _inaoqi.ALMemoryProxy_getMethodList(self)
    def getMicroEventList(self): return _inaoqi.ALMemoryProxy_getMicroEventList(self)
    def getModuleHelp(self): return _inaoqi.ALMemoryProxy_getModuleHelp(self)
    def getSubscribers(self, *args): return _inaoqi.ALMemoryProxy_getSubscribers(self, *args)
    def getTimestamp(self, *args): return _inaoqi.ALMemoryProxy_getTimestamp(self, *args)
    def getType(self, *args): return _inaoqi.ALMemoryProxy_getType(self, *args)
    def getUsage(self, *args): return _inaoqi.ALMemoryProxy_getUsage(self, *args)
    def insertData(self, *args): return _inaoqi.ALMemoryProxy_insertData(self, *args)
    def insertListData(self, *args): return _inaoqi.ALMemoryProxy_insertListData(self, *args)
    def isRunning(self, *args): return _inaoqi.ALMemoryProxy_isRunning(self, *args)
    def pCall(self): return _inaoqi.ALMemoryProxy_pCall(self)
    def ping(self): return _inaoqi.ALMemoryProxy_ping(self)
    def raiseEvent(self, *args): return _inaoqi.ALMemoryProxy_raiseEvent(self, *args)
    def raiseMicroEvent(self, *args): return _inaoqi.ALMemoryProxy_raiseMicroEvent(self, *args)
    def removeData(self, *args): return _inaoqi.ALMemoryProxy_removeData(self, *args)
    def removeEvent(self, *args): return _inaoqi.ALMemoryProxy_removeEvent(self, *args)
    def removeMicroEvent(self, *args): return _inaoqi.ALMemoryProxy_removeMicroEvent(self, *args)
    def setDescription(self, *args): return _inaoqi.ALMemoryProxy_setDescription(self, *args)
    def stop(self, *args): return _inaoqi.ALMemoryProxy_stop(self, *args)
    def subscribeToEvent(self, *args): return _inaoqi.ALMemoryProxy_subscribeToEvent(self, *args)
    def subscribeToMicroEvent(self, *args): return _inaoqi.ALMemoryProxy_subscribeToMicroEvent(self, *args)
    def subscriber(self, *args): return _inaoqi.ALMemoryProxy_subscriber(self, *args)
    def unregisterModuleReference(self, *args): return _inaoqi.ALMemoryProxy_unregisterModuleReference(self, *args)
    def unsubscribeToEvent(self, *args): return _inaoqi.ALMemoryProxy_unsubscribeToEvent(self, *args)
    def unsubscribeToMicroEvent(self, *args): return _inaoqi.ALMemoryProxy_unsubscribeToMicroEvent(self, *args)
    def version(self): return _inaoqi.ALMemoryProxy_version(self)
    def wait(self, *args): return _inaoqi.ALMemoryProxy_wait(self, *args)
    __swig_setmethods__["post"] = _inaoqi.ALMemoryProxy_post_set
    __swig_getmethods__["post"] = _inaoqi.ALMemoryProxy_post_get
    if _newclass:post = _swig_property(_inaoqi.ALMemoryProxy_post_get, _inaoqi.ALMemoryProxy_post_set)
    __swig_destroy__ = _inaoqi.delete_ALMemoryProxy
    __del__ = lambda self : None;
ALMemoryProxy_swigregister = _inaoqi.ALMemoryProxy_swigregister
ALMemoryProxy_swigregister(ALMemoryProxy)

# This file is compatible with both classic and new-style classes.

