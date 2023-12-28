# NOTE: the function should be called 'sim_fn'
sim_fn <- function(parameters) {

  # Extract parameters
  n_obs <- parameters$n_obs
  n_vars <- parameters$n_vars

  # Function to simulate regression data
  simulate_regression_data <- function(n_obs, n_vars) {

    # Generate random mean vector for the predictors
    mean_vector <- rep(0, n_vars)

    A <- matrix(runif(n_vars^2)*2-1, ncol=n_vars)
    Sigma <- t(A) %*% A

    # Simulate the predictor matrix X
    X <- MASS::mvrnorm(n_obs, mu = mean_vector, Sigma = Sigma)

    # Simulate regression coefficients
    beta <- rnorm(n_vars)

    # Simulate the response variable y
    y <- X %*% beta + rnorm(n_obs)

    # Return the simulated data
    return(list(y = y, X = X, beta = beta))
  }

  # Generate multivariate normally distributed data
  simulated_data <- simulate_regression_data(n_obs, n_vars)

  X <- simulated_data$X

  # Create a random forest model using the ranger package
  data_df <- data.frame(response = simulated_data$y, X)

  # Fit a random forest model using ranger
  rf_model <- ranger::ranger(response ~ ., data = data_df, num.trees = 100)

  # Return the random forest model
  return(rf_model)
}
