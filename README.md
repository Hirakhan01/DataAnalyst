# DataAnalyst
## Project 1
### Code Similarity and Plagiarism Detection 

It was my college Generative Artifical Intelligence project .

This repository provides tools for preprocessing, embedding, and comparing code snippets using advanced NLP techniques and machine learning models. It leverages pretrained models like CodeBERT to compute code embeddings and evaluate similarity.


## Features
1) Code Preprocessing:

-> Removes single-line and multi-line comments.

-> Normalizes whitespaces for cleaner code representation.

2) Code Embedding:

-> Uses a pretrained model (CodeBERT) to generate embeddings for   code snippets.

-> Tokenizes and processes input snippets for compatibility with the model.

3) Similarity Evaluation:

-> Computes cosine similarity between code embeddings to identify closely related or potentially plagiarized code.

## Key Libraries Used
--> numpy, pandas, matplotlib for data manipulation and visualization.

--> scikit-learn for cosine similarity computations.

--> transformers for model loading and embedding generation.

--> torch for deep learning operations.

## Usage/Examples
1. Preprocess Code:
Use the preprocess_code() function to clean raw code by removing comments and unnecessary spaces.

2. Embed Code:
The tokenize_and_embed() function generates normalized embeddings for input code snippets using CodeBERT.

3. Compare Code:
Compute similarity scores using cosine similarity on the generated embeddings.
