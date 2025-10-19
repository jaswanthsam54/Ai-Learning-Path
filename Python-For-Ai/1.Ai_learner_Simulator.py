# AI Learner Simulator — Mini Project
target = 100           #  The goal our "AI" is trying to reach
guess = 0              #  The AI’s current guess (starts from 0)
learning_rate = 0.7    #How big the adjustment per step (like learning rate)
epochs = 10            # How many times the AI will practice (epochs)
print("AI is trying to learn the target number...")
print(f"Target: {target}\n")
for epoch in range(1, epochs + 1):
    # Find the difference (error)
    error = target - guess
    # Update the guess using the learning rate
    guess = guess + learning_rate * error
    # Display progress
    print(f"Epoch {epoch}: Guess = {guess:.2f}, Error = {error:.2f}")
print("\n Training complete!")
print(f"Final Guess after {epochs} epochs: {guess:.2f}")