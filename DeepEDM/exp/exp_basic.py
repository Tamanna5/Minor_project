import os
import torch
from models import DeepEDM


class Exp_Basic(object):
    def __init__(self, args):
        self.args = args
        self.model_dict = {
            'DeepEDM': DeepEDM,
        }
        if args.model == 'Mamba':
            print('Please make sure you have successfully installed mamba_ssm')
            from models import Mamba
            self.model_dict['Mamba'] = Mamba

        self.device = self._acquire_device()
        self.model = self._build_model()#.to(self.device)

    def _build_model(self):
        raise NotImplementedError
        return None

    def _acquire_device(self):
        use_cuda = torch.cuda.is_available() and bool(self.args.use_gpu)
        if use_cuda:
            os.environ["CUDA_VISIBLE_DEVICES"] = str(
                self.args.gpu) if not self.args.use_multi_gpu else self.args.devices
            device = torch.device('cuda:{}'.format(self.args.gpu))
            print('Use GPU: cuda:{}'.format(self.args.gpu))
        else:
            # Normalize flags for CPU-only env
            self.args.use_gpu = False
            self.args.use_multi_gpu = False
            device = torch.device('cpu')
            print('Use CPU')
        return device

    def _get_data(self):
        pass

    def vali(self):
        pass

    def train(self):
        pass

    def test(self):
        pass
