// types are returned correctly in list.get()

ArrayList test = new ArrayList();

test.add("String");
test.add(1);

println(test.get(0).getClass());
println(test.get(1).getClass());

// for each loop (with simple array)

int[] intArray = new int[5];
for (int i = 0; i < intArray.length; i++)
  intArray[i] = 100 + i;
  
for (int number: intArray)
  println(number);

// for each (with ArrayList)

ArrayList<Integer> list2 = new ArrayList<Integer>();
for (int i = 0; i < 5; i++)
  list2.add(1000+i);

for (int number: list2)
  println(number);
  
// the same as

int number;
for (int i = 0; i < list2.size(); i++) {
  number = list2.get(i);
  println(number);
}
