import torch
import faiss
print("faiss version: ", faiss.__version__)
print("faiss gpu version: ", faiss.get_num_gpus())
print("Torch version:", torch.__version__)
print("CUDA 可用:", torch.cuda.is_available())
print("GPU 名稱:", torch.cuda.get_device_name(0) if torch.cuda.is_available() else None)
print("Torch CUDA 版本:", torch.version.cuda)
