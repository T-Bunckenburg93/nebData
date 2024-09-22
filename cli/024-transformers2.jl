using Flux
using Random

Hdims = 8  # Dimensionality of the fruit vectors
inDims = 3

# Define fruit vectors (e.g., size, sweetness, color)
fruit_apple = [0.8, 0.9, 0.6]
fruit_banana = [0.7, 0.6, 0.8]
fruit_orange = [0.9, 0.5, 0.7]

# Define example fruit bowls (each bowl contains multiple fruits)
fruit_bowl_1 = [fruit_apple, fruit_banana]  # Good fruit bowl
fruit_bowl_2 = [fruit_orange, fruit_banana]  # Bad fruit bowl
fruit_bowl_2 = [fruit_banana, fruit_banana]  # Bad fruit bowl

# Stack the fruit vectors into a matrix for each bowl
function create_bowl_matrix(fruit_bowl)
    hcat(fruit_bowl...)
end

# Attention mechanism (trainable using Flux)
function attention(query, keys, values)
    # Compute attention scores using softmax(QK^T / sqrt(d_k))
    d_k = size(keys, 1)  # Dimensionality of the keys
    attention_scores = softmax((keys' * query) / sqrt(d_k))  # Softmax to normalize
    
    # Weighted sum of values
    weighted_values = values * attention_scores
    return weighted_values, attention_scores
end

# Learnable Dense layers for queries, keys, and values (input size is now 5)
key_layer = Dense(Hdims, Hdims)   # 5 input dimensions -> 5 key dimensions
query_layer = Dense(Hdims, Hdims) # 5 input dimensions -> 5 query dimensions
value_layer = Dense(Hdims, Hdims) # 5 input dimensions -> 5 value dimensions

# Simple feedforward encoder (works on individual fruit vectors)
encoder = Dense(inDims, Hdims, relu)  # Encodes a 3D fruit vector into 5D latent space

# Classifier to predict "good" (1) or "bad" (0)
classifier = Chain(
    Dense(Hdims, 3, relu),  # Hidden layer (5D latent space -> 3D)
    Dense(3, 2),        # Output layer (2 classes: good or bad)
    softmax             # Probability distribution
)

mha = MultiHeadAttention(Hdims, nheads = 8)

# Apply encoder to each fruit in the bowl separately
function encode_fruits(fruit_bowl_matrix)
    return hcat([encoder(fruit_bowl_matrix[:, i]) for i in 1:size(fruit_bowl_matrix, 2)]...)
end

# Function to apply the whole model to a fruit bowl
function classify_bowl(fruit_bowl_matrix)
    # Apply encoder to each fruit in the bowl separately
    # fruit_bowl_matrix = create_bowl_matrix(fruit_bowl_1)
    encoded_fruits = encode_fruits(fruit_bowl_matrix)
    
    # Generate queries, keys, and values for attention mechanism
    keys = key_layer(encoded_fruits)
    queries = query_layer(encoded_fruits)
    values = value_layer(encoded_fruits)
    

    keys = reshape(keys,size(keys)[1],size(keys)[2],1)
    queries = reshape(queries,size(queries)[1],size(queries)[2],1)
    values = reshape(values,size(values)[1],size(values)[2],1)

    # Apply attention to encoded fruits
    # weighted_fruits, attention_scores = attention(queries, keys, values)
    
    # q = rand(Float32, (16, 10, 32))
    # k = rand(Float32, (16, 20, 32))
    # v = rand(Float32, (16, 20, 32))
    weighted_fruits, attention_scores = mha(queries, keys, values) 
    # weighted_fruits, attention_scores = mha(query_layer, key_layer, value_layer) 

    
    # Classify based on the weighted representation
    output = classifier(weighted_fruits)
    return output, attention_scores
end

# Create fruit bowl matrices
bowl_1_matrix = create_bowl_matrix(fruit_bowl_1)
bowl_2_matrix = create_bowl_matrix(fruit_bowl_2)
bowl_3_matrix = create_bowl_matrix(fruit_bowl_3)


# Simulate a batch of fruit bowls (with corresponding labels: 1 = good, 0 = bad)
X = [bowl_1_matrix, bowl_2_matrix, bowl_3_matrix]
y = [1, 0, 1]


# Loss function: cross-entropy for classification
loss(x, y) = Flux.crossentropy(classify_bowl(x)[1][1], Flux.onehot(y, 0:1))


classify_bowl(X[1])[1]
Flux.onehot(y[1], 0:1)

# Training setup
opt = ADAM()

# Training loop
for epoch in 1:100
    for (x, target) in zip(X, y)
        gs = gradient(() -> loss(x, target), Flux.params(encoder, classifier, key_layer, query_layer, value_layer))
        Flux.Optimise.update!(opt, Flux.params(encoder, classifier, key_layer, query_layer, value_layer), gs)
    end
end

# After training, test the model with a new fruit bowl
bowl_test = create_bowl_matrix([fruit_apple, fruit_orange])
output, attention_scores = classify_bowl(bowl_test)

println("Classification output: ", output)
println("Attention scores: ", attention_scores)
