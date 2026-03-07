# CPU

The purpose of this project is simple: **to build a CPU**.

Now you might be thinking, a CPU as a first-year college student, are you crazy?
Maybe. But trying something difficult is one of the best ways to learn, and honestly, it doesn't hurt to try.

Before writing any code, I first had to decide **which architecture to use**. After reading about different options and talking with a few professors, I decided to go with **RISC-V**. It’s open, well documented, and widely used for learning processor design.

The next question was: **how many bits should the CPU support?**

While **64-bit processors** are the industry standard today, the goal of this project is learning rather than building a production CPU. Increasing the bit width also increases the complexity significantly, so I chose **32-bit**. This might give rise to the question, "Isnt 32 bit hard too", well yes but also I enjoy chaos so seemed like a good choice

---

# First Step: Building the ALU

The first major component I implemented was the **ALU (Arithmetic Logic Unit)**.

Not just any ALU one that uses a **Manchester Carry Adder** for arithmetic operations.

---

## ALU Design

To build the ALU, the following inputs are required:

### Inputs

- **A** – 32-bit operand
- **B** – 32-bit operand
- **M_control** – 2-bit multiplexer control signal that selects the operation

### Outputs

- **result** – 32-bit output of the operation
- **Cout** – carry out of the most significant bit
- **V** – overflow flag

---

## Internal Signals

Inside the module, several signals are used:

- **P** – Propagate signal
- **G** – Generate signal
- **C** – Carry signals
- **Sub** – Indicates whether the operation is subtraction

The carry array **C** is defined as **33 bits instead of 32** so that the final carry out can be stored.

---

# Adder and Subtractor Design

To reduce the number of required components, the **adder and subtractor share the same logic**.

Subtraction is implemented using the **two's complement method**:

The control signal **Sub** determines whether subtraction is performed.

- If **Sub = 0** → addition
- If **Sub = 1** → subtraction

The **initial carry input** is set equal to **Sub**:

- For addition → `C[0] = 0`
- For subtraction → `C[0] = 1`

---

# Manchester Carry Logic

The ALU uses **propagate and generate signals** to calculate carries.

Propagate signal:

`P = A^B`

Generate Signal:
`G = A&B`

Carry is calculated using:
`C[i+1] = G[i] | (P[i] & C[i])`

The final sum is computed using:
`Sum = P ^ C[31:0]`

Overflow is detected using:

`V = Cout ^ C[31]`

# Operation Selection

A multiplexer controlled by **M_control** determines the final output.

| M_control | Operation   |
| --------- | ----------- |
| 00        | Addition    |
| 01        | Subtraction |
| 10        | Bitwise AND |
| 11        | Bitwise OR  |

---

# Summary

This ALU is the **first building block** of a larger goal: designing a **32-bit RISC-V CPU from scratch**.  
Future components will include registers, control logic, memory interfaces, and instruction decoding.
