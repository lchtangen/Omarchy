# Synapse — Local Neural Engine

Run large language models locally on Omarchy. Ollama integration, model management,
inference optimization, and AI prompt pipelines — all offline, all private.

## Structure

```
synapse/
├── models/              # Local LLM management
│   ├── ollama.conf      # Ollama server config (GPU, context, concurrency)
│   ├── models.yml       # Installed model manifest
│   └── pull.sh          # Batch model downloader
├── inference/           # Inference optimization
│   ├── gpu.conf         # GPU/CUDA/ROCm configuration
│   ├── quant.sh         # Model quantization pipeline
│   └── benchmark.sh     # Inference speed benchmarks
└── prompts/             # System prompts for local models
    ├── omarchy-assist   # Omarchy system assistant prompt
    └── code-review      # Local code review prompt
```

## Setup

```bash
# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Pull models
ollama pull llama3.2:3b        # Fast, daily driver
ollama pull codellama:7b       # Code generation
ollama pull nomic-embed-text   # Embeddings

# Use with Omarchy
ollama run llama3.2:3b "Generate a Tokyo Night variant with green accents"
```
