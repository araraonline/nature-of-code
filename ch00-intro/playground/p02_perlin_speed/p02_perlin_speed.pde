/* Perlin Noise speed
 *
 * Example made to experiment with different
 * increments to the t value.
 *
 * Values to test: 0.01, 0.02, 0.05, 0.1, 1, 1000, 0.0001
 */

float t = 0;

void draw() {
  float num = noise(t);
  println(num);
  t += 0.01;
}

// Values closer in time are more related (closer to one another).
