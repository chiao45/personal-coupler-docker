import numpy as np


class InterfaceData(object):
    """Assume scalars for now"""

    def __init__(self, size, value, **kwargs):
        self.curr = np.ones(size, dtype=np.float64) * value
        self.prev = self.curr.copy()
        self.res = np.zeros(size, dtype=np.float64)
        self.res_prev = self.res.copy()
        self.tag = kwargs.pop('tag', None)

    def backup(self):
        self.prev[:] = self.curr

    def update_res(self):
        self.res_prev[:] = self.res
        self.res[:] = self.curr - self.prev


class DynamicUnderRelaxation(object):
    def __init__(self, init_omega, **kwargs):
        if init_omega < 0.0 or init_omega > 1.0:
            self.omega = 1.0
        else:
            self.omega = init_omega

    def determine_omega(self, idata):
        assert isinstance(idata, InterfaceData)
        omega = self.omega
        bot = np.linalg.norm(idata.res - idata.res_prev)**2
        if bot <= 1e-24:
            self.omega = 1.0
        else:
            self.omega = -omega * np.dot(idata.res_prev, idata.res - idata.res_prev) / bot
#         if self.omega > 1.0:
#             self.omega = 1.0

    def update_solution(self, idata):
        assert isinstance(idata, InterfaceData)
        idata.curr[:] = (1.0 - self.omega) * idata.prev + \
            self.omega * idata.curr


class RelativeCovergenceMonitor(object):
    def __init__(self, tol, **kwargs):
        if tol <= 0.0:
            self.tol = 1e-6
        else:
            self.tol = tol

    def determine_convergence(self, idata):
        assert isinstance(idata, InterfaceData)
        bot = np.linalg.norm(idata.curr)
        if bot <= 1e-12:
            bot = 1.0
        err = np.linalg.norm(idata.res) / bot
        return err <= self.tol
    
    
class AbsCovergenceMonitor(object):
    def __init__(self, tol, **kwargs):
        if tol <= 0.0:
            self.tol = 1e-6
        else:
            self.tol = tol

    def determine_convergence(self, idata):
        assert isinstance(idata, InterfaceData)
        err = max(abs(idata.res))
        return err <= self.tol
