# How to Run DeepEDM and FEDFormer Models

Complete guide to execute both time series forecasting models.

## 📋 Prerequisites Setup

### 1. System Requirements
- Python 3.7 or higher
- CUDA-capable GPU (recommended but optional)
- At least 8GB RAM

### 2. Initial Setup

First, navigate to your project directory:
```bash
cd path/to/Minor_project
```

## 🔧 Installation Steps

### Option 1: Install Both Models Separately

**Install DeepEDM:**
```bash
cd DeepEDM
pip install -r requirements.txt
cd ..
```

**Install FEDFormer:**
```bash
cd FEDFormer
pip install -r requirements.txt
cd ..
```

### Option 2: Create Virtual Environments (Recommended)

**For DeepEDM:**
```bash
# Create virtual environment
python -m venv deepedm_env

# Activate it
# On macOS/Linux:
source deepedm_env/bin/activate
# On Windows:
deepedm_env\Scripts\activate

# Install dependencies
cd DeepEDM
pip install -r requirements.txt
cd ..
deactivate
```

**For FEDFormer:**
```bash
# Create virtual environment
python -m venv fedformer_env

# Activate it
# On macOS/Linux:
source fedformer_env/bin/activate
# On Windows:
fedformer_env\Scripts\activate

# Install dependencies
cd FEDFormer
pip install -r requirements.txt
cd ..
deactivate
```

## 🚀 Running DeepEDM

### Method 1: Run Single Experiment

```bash
cd DeepEDM

# Basic run with default parameters
python run.py --model DeepEDM --data ETTh1

# Run with specific parameters
python run.py \
  --model DeepEDM \
  --data ETTh1 \
  --seq_len 96 \
  --pred_len 96 \
  --batch_size 32 \
  --learning_rate 0.001 \
  --train_epochs 10
```

### Method 2: Run Multiple Experiments Using Scripts

```bash
cd DeepEDM/scripts

# Make scripts executable (macOS/Linux)
chmod +x *.sh

# Run all ETTh1 experiments
bash run_ETTh1.sh

# Run all ETTh2 experiments
bash run_ETTh2.sh

# Run specific prediction length
bash run_ETTh1_96.sh   # For 96-step prediction
bash run_ETTh1_192.sh  # For 192-step prediction
bash run_ETTh1_336.sh  # For 336-step prediction
bash run_ETTh1_720.sh  # For 720-step prediction
```

### Method 3: Run All Experiments at Once

```bash
cd DeepEDM

# Run all experiments sequentially
for pred_len in 96 192 336 720
do
  python run.py --data ETTh1 --pred_len $pred_len
  python run.py --data ETTh2 --pred_len $pred_len
done
```

## 🚀 Running FEDFormer

### Method 1: Run Single Experiment

```bash
cd FEDFormer

# Basic run with default parameters
python run.py --model FEDformer --data ETTh1

# Run with specific parameters
python run.py \
  --model FEDformer \
  --data ETTh1 \
  --seq_len 96 \
  --pred_len 96 \
  --batch_size 32 \
  --learning_rate 0.0001 \
  --train_epochs 10
```

### Method 2: Run Multiple Experiments Using Scripts

```bash
cd FEDFormer/scripts

# Make scripts executable (macOS/Linux)
chmod +x *.sh

# Run all ETTh1 experiments
bash run_ETTh1.sh

# Run all ETTh2 experiments
bash run_ETTh2.sh
```

### Method 3: Run All Experiments at Once

```bash
cd FEDFormer

# Run all experiments sequentially
for pred_len in 96 192 336 720
do
  python run.py --model FEDformer --data ETTh1 --pred_len $pred_len
  python run.py --model FEDformer --data ETTh2 --pred_len $pred_len
done
```

## 🔄 Running Both Models Sequentially

Create a master script to run both models:

```bash
# Create a file named run_all.sh in Minor_project directory
cd Minor_project

# Create the script
cat > run_all.sh << 'EOF'
#!/bin/bash

echo "Starting DeepEDM Experiments..."
cd DeepEDM
for pred_len in 96 192 336 720
do
  echo "Running DeepEDM with prediction length: $pred_len"
  python run.py --data ETTh1 --pred_len $pred_len
  python run.py --data ETTh2 --pred_len $pred_len
done
cd ..

echo "Starting FEDFormer Experiments..."
cd FEDFormer
for pred_len in 96 192 336 720
do
  echo "Running FEDFormer with prediction length: $pred_len"
  python run.py --model FEDformer --data ETTh1 --pred_len $pred_len
  python run.py --model FEDformer --data ETTh2 --pred_len $pred_len
done
cd ..

echo "All experiments completed!"
EOF

# Make it executable
chmod +x run_all.sh

# Run it
./run_all.sh
```

## 📊 Common Parameters Explained

| Parameter | Description | Default | Example Values |
|-----------|-------------|---------|----------------|
| `--model` | Model name | - | DeepEDM, FEDformer |
| `--data` | Dataset name | ETTh1 | ETTh1, ETTh2 |
| `--seq_len` | Input sequence length | 96 | 96, 192, 336 |
| `--pred_len` | Prediction horizon | 96 | 96, 192, 336, 720 |
| `--batch_size` | Training batch size | 32 | 16, 32, 64 |
| `--learning_rate` | Learning rate | 0.001 | 0.0001, 0.001, 0.01 |
| `--train_epochs` | Number of epochs | 10 | 5, 10, 20 |
| `--patience` | Early stopping patience | 3 | 3, 5, 10 |

## 🔍 Checking Results

After running experiments, check the results:

**DeepEDM Results:**
```bash
cd DeepEDM

# View text results
cat ETTh1_ETTh1_96sl96_pl96.txt
cat ETTh2_ETTh2_192sl96_pl192.txt

# View logs
cat logs/latest_log.txt

# Check saved models
ls checkpoints/
```

**FEDFormer Results:**
```bash
cd FEDFormer

# View logs
cat logs/latest_log.txt

# Check saved models
ls checkpoints/
```

## 🐛 Troubleshooting

### Issue: Module not found errors
```bash
# Make sure you're in the correct directory
pwd

# Reinstall requirements
pip install -r requirements.txt --upgrade
```

### Issue: CUDA out of memory
```bash
# Reduce batch size
python run.py --batch_size 16

# Or run on CPU
python run.py --use_gpu False
```

### Issue: Permission denied on scripts
```bash
# Make scripts executable
chmod +x scripts/*.sh
```

### Issue: Data not found
```bash
# Check if data directory exists
ls data/

# Download data if necessary (check model README for data source)
```

## 💡 Quick Start Commands

**Run DeepEDM once quickly:**
```bash
cd Minor_project/DeepEDM && python run.py --data ETTh1 --pred_len 96
```

**Run FEDFormer once quickly:**
```bash
cd Minor_project/FEDFormer && python run.py --model FEDformer --data ETTh1 --pred_len 96
```

**Run both with default settings:**
```bash
# Terminal 1
cd Minor_project/DeepEDM && python run.py

# Terminal 2 (open new terminal)
cd Minor_project/FEDFormer && python run.py
```

## 📝 Tips

1. **Start with short experiments**: Use `--train_epochs 1` for testing
2. **Monitor GPU usage**: Use `nvidia-smi` to check GPU memory
3. **Save outputs**: Redirect output to file: `python run.py > output.log 2>&1`
4. **Background execution**: Use `nohup python run.py &` for long runs
5. **Compare results**: Keep logs organized by timestamp

## 🎯 Recommended Workflow

1. Test with one quick run to ensure everything works
2. Run a single prediction length for both models
3. Compare results before running all experiments
4. Run full batch of experiments using scripts
5. Analyze and compare final results