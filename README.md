# UART-Based Configurable ALU System

## Overview

This project implements a configurable **UART-controlled Arithmetic Logic Unit (ALU) system** with register-file access, clock-domain crossing, asynchronous FIFO buffering, UART communication, programmable UART configuration, and clock gating.

The system allows a master device to communicate with the hardware through UART commands. Received commands are decoded by the system controller, which can access the register file, configure UART-related parameters, perform ALU operations, and transmit results back to the master.

The architecture is divided into two primary clock domains:

- **Reference Clock Domain (`REF_CLK`)**
  - Register File
  - ALU
  - Clock Gating
  - System Controller

- **UART Clock Domain (`UART_CLK`)**
  - UART Transmitter
  - UART Receiver
  - Pulse Generator
  - Clock Divider

Dedicated synchronization and clock-domain-crossing blocks connect the two domains, including reset synchronizers, a data synchronizer, and an asynchronous FIFO.

---

## System Architecture

The complete system is organized around a central **SYS_CTRL** controller.

The general communication and processing flow is:

```text
                 UART Interface
                      │
          ┌───────────┴───────────┐
          │                       │
      UART_RX                 UART_TX
          │                       ▲
          │                       │
          ▼                       │
      SYS_CTRL ───────► ASYNC_FIFO
          │
    ┌─────┴─────┐
    │           │
    ▼           ▼
 RegFile       ALU
    │           │
    └─────┬─────┘
          │
       REF_CLK
```

The system also contains the clock-domain-crossing infrastructure required to safely transfer control and data between the reference-clock and UART-clock domains.

---

## Main System Blocks

The system consists of the following major blocks:

### Reference Clock Domain

- `RegFile`
- `ALU`
- `CLK_GATING`
- `SYS_CTRL`

### UART Clock Domain

- `UART_TX`
- `UART_RX`
- `PULSE_GEN`
- `CLK_DIVIDER`

### Synchronization and CDC Infrastructure

- `RST_SYNC`
- `DATA_SYNC`
- `ASYNC_FIFO`

The overall organization and block relationships are defined by the project specification.

---

## Clock Domains

The design uses two independent clock domains.

### Reference Clock Domain

The reference clock is:

```text
REF_CLK = 50 MHz
```

This domain contains the main control and processing logic:

- Register File
- System Controller
- ALU
- Clock Gating

The ALU receives its clock through the clock-gating block controlled by `SYS_CTRL`.

### UART Clock Domain

The UART clock is:

```text
UART_CLK = 3.6864 MHz
```

This domain contains:

- UART Receiver
- UART Transmitter
- Pulse Generator
- Clock Divider

The UART-related clocking can be configured through the register-file configuration registers.

---

## Register File

The Register File provides storage and configuration registers for the system.

Its clock and reset are associated with the reference-clock domain:

```text
CLK = REF_CLK
RST = RST_SYNC
```

The address width is parameterized, with a default width of 4 bits.

The Register File supports:

- Write operations
- Read operations
- Address selection
- Write data
- Read data
- Read-valid indication

### Register Map

| Address | Register | Purpose |
|---|---|---|
| `0x0` | `REG0` | ALU operand A |
| `0x1` | `REG1` | ALU operand B |
| `0x2` | `REG2` | UART configuration |
| `0x3` | `REG3` | Clock-divider configuration |

The outputs of these registers are connected to the corresponding system blocks.

```text
REG0 ─────────► ALU Operand A
REG1 ─────────► ALU Operand B
REG2 ─────────► UART Configuration
REG3 ─────────► Clock Divider
```

---

## UART Configuration Register

`REG2` contains UART-related configuration fields.

### `REG2` Format

| Bits | Field | Default |
|---|---|---|
| `[0]` | Parity Enable | `1` |
| `[1]` | Parity Type | `0` |
| `[7:2]` | Prescale | `32` |

The parity configuration is passed to the UART transmitter and receiver.

The prescale field is used by the UART receiver for its timing configuration.

---

## Clock Divider Register

`REG3` contains the programmable clock-division ratio.

| Bits | Field | Default |
|---|---|---|
| `[7:0]` | Division Ratio | `32` |

The clock divider operates in the UART clock domain and generates the divided clock used by the UART transmitter and receiver.

The divider enable is specified as always enabled.

---

## ALU

The ALU performs the arithmetic and logical operations requested by the master.

Its clock is supplied by the clock-gating block:

```text
CLK = GATED_CLK
```

The reset is supplied by the reset synchronizer.

### ALU Inputs

The ALU receives:

- Operand A from `REG0`
- Operand B from `REG1`
- `ALU_FUN` from `SYS_CTRL`
- Enable signal from `SYS_CTRL`

### ALU Outputs

The ALU provides:

- `ALU_OUT`
- `OUT_VALID`

These signals are returned to `SYS_CTRL`, which manages the subsequent response to the master.

---

## Supported ALU Operations

The system specification defines the following ALU operations:

| Operation | Description |
|---|---|
| ADD | Addition |
| SUB | Subtraction |
| MUL | Multiplication |
| DIV | Division |
| AND | Bitwise AND |
| OR | Bitwise OR |
| NAND | Bitwise NAND |
| NOR | Bitwise NOR |
| XOR | Bitwise XOR |
| XNOR | Bitwise XNOR |
| CMP A = B | Equality comparison |
| CMP A > B | Greater-than comparison |
| A >> 1 | Shift A right by one |
| A << 1 | Shift A left by one |

The operation is selected through the `ALU_FUN` control signal generated by `SYS_CTRL`.

---

## Clock Gating

The clock-gating block controls the clock supplied to the ALU.

```text
REF_CLK
   │
   ▼
CLK_GATING
   ▲
   │
 CLK_EN
   │
 SYS_CTRL
```

### Inputs

- `REF_CLK`
- `CLK_EN`

### Output

- `GATED_CLK`

The `CLK_EN` signal is controlled by `SYS_CTRL`.

This provides a dedicated interface between the system controller and the ALU clock.

---

## SYS_CTRL

`SYS_CTRL` is the main control block of the system.

It interfaces with:

- Register File
- ALU
- UART Receiver
- UART Transmitter
- Clock Divider
- Asynchronous FIFO

### SYS_CTRL → ALU

The controller generates:

- `ALU_FUN`
- `EN`
- `CLK_EN`

The ALU returns:

- `ALU_OUT`
- `OUT_VALID`

### SYS_CTRL → Register File

The controller manages:

- Register-file address
- Write enable
- Read enable
- Write data

The Register File returns:

- Read data
- Read-valid indication

### SYS_CTRL ↔ UART

The controller receives:

- RX data
- RX data-valid

The controller produces:

- TX data
- TX data-valid

The controller also interfaces with the asynchronous FIFO to transfer data between the reference-clock and UART-clock domains.

---

## UART Transmitter

The UART transmitter operates in the UART clock domain.

### Inputs

- `CLK`
- `RST`
- `PAR_EN`
- `PAR_TYP`
- `P_DATA`
- `DATA_VALID`

### Outputs

- `S_DATA`
- `Busy`

The serial output is connected to the external UART transmit interface:

```text
S_DATA → TX_OUT
```

The transmitter receives its parallel data through the asynchronous FIFO path.

---

## UART Receiver

The UART receiver accepts serial data from the external UART interface.

### Inputs

- `UART_CLK`
- Reset synchronization
- Prescale
- Parity enable
- Parity type
- `RX_IN`

### Outputs

- Parallel `P_DATA`
- `DATA_VLD`
- `PAR_ERR`
- `STP_ERR`

The received information is transferred toward the system controller through the synchronization path.

```text
RX_IN
  │
  ▼
UART_RX
  │
  ▼
DATA_SYNC
  │
  ▼
SYS_CTRL
```

The receiver therefore provides the command data used by the system controller.

---

## Pulse Generator

The pulse generator is located in the UART clock domain.

It receives a level signal from the UART transmitter and generates a pulse used to control the asynchronous FIFO read operation.

```text
UART_TX
   │
 LVL_SIG
   ▼
PULSE_GEN
   │
PULSE_SIG
   ▼
ASYNC_FIFO
```

### Signals

- `CLK`
- Reset
- `LVL_SIG`
- `PULSE_SIG`

The generated pulse provides the read-side control interface for the asynchronous FIFO.

---

## Reset Synchronization

The design uses reset synchronization blocks to provide synchronized resets within the respective clock domains.

The reset synchronizer receives:

```text
Reset + Clock
```

and generates a synchronized active-low reset.

Separate synchronized reset paths are used for the different clock domains and CDC-related blocks.

---

## Data Synchronization

The data synchronizer transfers an 8-bit bus from one clock domain to another.

### Inputs

- 8-bit unsynchronized data bus
- Bus enable
- Destination clock
- Destination reset

### Outputs

- 8-bit synchronized data bus
- Enable pulse

The synchronizer provides the required interface for transferring UART-received data into the reference-clock domain.

---

## Asynchronous FIFO

The asynchronous FIFO provides a buffered data path between the two clock domains.

It separates the write and read sides using independent clocks and resets.

### Write Side

```text
W_CLK  = REF_CLK
W_RST  = RST_SYNC_1
W_INC  = SYS_CTRL
```

The write-side data originates from `SYS_CTRL`.

### Read Side

```text
R_CLK  = UART Clock Domain
R_RST  = RST_SYNC_2
R_INC  = PULSE_GEN
```

The read-side data is provided to `UART_TX`.

### FIFO Interfaces

```text
SYS_CTRL
    │
 WR_DATA
    ▼
┌──────────────┐
│ ASYNC_FIFO   │
└──────────────┘
    │
 RD_DATA
    ▼
 UART_TX
```

The FIFO also provides:

- `FULL` status toward `SYS_CTRL`
- `EMPTY` status toward `UART_TX`

The default FIFO data width is:

```text
8 bits
```

---

## Clock Domain Crossing

Because the system contains two independent clock domains, dedicated CDC structures are used.

The main CDC elements are:

### Reset Synchronizers

Used to generate synchronized reset signals for the corresponding clock domains.

### Data Synchronizer

Used for transferring the UART receiver's parallel data into the reference-clock domain.

### Asynchronous FIFO

Used for transferring response data from the reference-clock domain toward the UART transmitter.

The overall CDC structure can be represented as:

```text
             REF_CLK DOMAIN
                  │
             ┌────┴────┐
             │         │
          SYS_CTRL   RegFile
             │
             ▼
          ASYNC FIFO
             │
             ▼
          UART_TX
             │
             │
        UART CLOCK DOMAIN
```

---

## Command Interface

The system is controlled through UART command frames.

The master sends command bytes through the UART receiver. The received command is passed to `SYS_CTRL`, which interprets the command and performs the requested system operation.

The specification defines four primary command types:

1. Register File Write
2. Register File Read
3. ALU Operation With Operands
4. ALU Operation Without Operands

---

## Register File Write Command

The Register File write operation uses **three UART frames**.

The command identifier is:

```text
0xAA
```

The command is followed by the required data and address information according to the specified protocol.

The controller receives the frames through `UART_RX` and uses them to perform the corresponding Register File write operation.

---

## Register File Read Command

The Register File read operation uses **two UART frames**.

The command identifier is:

```text
0xBB
```

The command is followed by the register address.

The requested register data is obtained from the Register File and returned through the UART transmission path.

---

## ALU Operation With Operands

An ALU operation with explicitly supplied operands uses **four UART frames**.

The command identifier is:

```text
0xCC
```

The command sequence contains:

```text
Command
Operand A
Operand B
ALU Function
```

The controller uses the received information to configure the ALU operation.

---

## ALU Operation Without Operands

An ALU operation without separately supplied operands uses **two UART frames**.

The command identifier is:

```text
0xDD
```

The command sequence contains:

```text
Command
ALU Function
```

For this command type, the ALU operates using the operands already available through the system's register-file configuration.

---

## System Operation

The normal system transaction follows the sequence below:

```text
Master
  │
  │ UART Command
  ▼
UART_RX
  │
  │ Received Data
  ▼
DATA_SYNC
  │
  ▼
SYS_CTRL
  │
  ├──────────────► RegFile
  │
  └──────────────► ALU
                       │
                       │ ALU_OUT
                       ▼
                    SYS_CTRL
                       │
                       ▼
                  ASYNC_FIFO
                       │
                       ▼
                    UART_TX
                       │
                       │ Serial Result
                       ▼
                    Master
```

In general:

1. The master sends a command through UART.
2. `UART_RX` receives the serial command.
3. The received data is synchronized into the reference-clock domain.
4. `SYS_CTRL` interprets the command.
5. The controller accesses the Register File or configures the ALU.
6. The requested operation is performed.
7. The resulting information is passed back to `SYS_CTRL`.
8. The response is transferred through the asynchronous FIFO.
9. `UART_TX` serializes the response.
10. The result is returned to the master.

---

## Register Address Organization

The specification separates the reserved configuration/operand registers from the normal Register File address range.

### Reserved Addresses

```text
0x0 – 0x3
```

These addresses correspond to:

```text
0x0 → REG0
0x1 → REG1
0x2 → REG2
0x3 → REG3
```

They are used for ALU operands and system configuration.

### Normal Register File Range

```text
0x4 – 0x15
```

This range is used for normal Register File operations.

---

## Initial Configuration

Before normal system transactions, the testbench/configuration sequence initializes the system configuration through Register File writes.

The configuration registers involved are:

```text
REG2 → UART configuration
REG3 → Clock-divider configuration
```

The specified default configuration values are:

```text
REG2[0]   = 1
REG2[1]   = 0
REG2[7:2] = 32

REG3[7:0] = 32
```

The clock-divider enable is specified as always enabled.

---

## Design Parameters

The design includes configurable parameters in several blocks.

### Register File

- Address width is parameterized.
- Default address width: 4 bits.

### Asynchronous FIFO

- Data width is parameterized.
- Default data width: 8 bits.

### UART Configuration

UART operation is configurable through:

- Parity enable
- Parity type
- Prescale

### Clock Divider

The UART clock division ratio is programmable through `REG3`.

---

## Project Structure

A typical organization of the project can be represented as:

```text
Final_System/
│
├── RTL/
│   ├── RegFile
│   ├── ALU
│   ├── SYS_CTRL
│   ├── CLK_GATING
│   ├── UART_TX
│   ├── UART_RX
│   ├── PULSE_GEN
│   ├── CLK_DIVIDER
│   ├── RST_SYNC
│   ├── DATA_SYNC
│   └── ASYNC_FIFO
│
├── Testbench/
│   └── System Testbench
│
├── Documentation/
│   └── Project Specification
│
└── README.md
```

The exact source-file names and directory organization can be adapted to the implementation environment.

---

## Verification Strategy

The system-level verification flow is based on exercising the UART command interface and observing the resulting system behavior.

The verification sequence described by the specification includes:

### Configuration

The system is initially configured through Register File writes to the reserved configuration addresses.

### Register File Transactions

The master sends Register File write and read commands through UART.

### ALU Transactions

The master sends ALU commands using either:

- Explicit operands
- Previously configured operands

### UART Reception

The UART receiver accepts the command frames and produces parallel data for the system controller.

### Command Processing

`SYS_CTRL` interprets the received command and coordinates the appropriate Register File or ALU operation.

### Result Transmission

The generated result is transferred through the asynchronous FIFO to `UART_TX`, where it is serialized and returned to the master.

This verification structure exercises the complete system path rather than isolating the UART, controller, Register File, and ALU as independent interfaces.

---

## System Specifications

| Parameter | Specification |
|---|---|
| Reference Clock | `50 MHz` |
| UART Clock | `3.6864 MHz` |
| Clock Divider Enable | Always enabled |
| Clock Division Ratio | `32` default |
| UART Prescale | `32` default |
| FIFO Data Width | `8 bits` default |
| Register Address Width | `4 bits` default |
| Parity Enable | Enabled by default |
| Parity Type | `0` default |

---

## Supported Commands

| Command | Code | Frames | Function |
|---|---:|---:|---|
| Register File Write | `0xAA` | 3 | Write register data |
| Register File Read | `0xBB` | 2 | Read register data |
| ALU Operation With Operands | `0xCC` | 4 | Execute operation using supplied operands |
| ALU Operation Without Operands | `0xDD` | 2 | Execute operation using configured operands |

---

## Why This Architecture

The architecture separates system control, arithmetic processing, UART communication, and clock-domain crossing into dedicated modules.

This provides clear functional boundaries:

- `SYS_CTRL` manages system sequencing and command interpretation.
- `RegFile` provides storage and configuration registers.
- `ALU` performs arithmetic and logical operations.
- `UART_RX` receives commands.
- `UART_TX` transmits responses.
- `CLK_DIVIDER` provides UART timing configuration.
- `CLK_GATING` controls the ALU clock.
- `DATA_SYNC` handles synchronized data transfer.
- `ASYNC_FIFO` provides buffered clock-domain crossing.
- `RST_SYNC` provides synchronized reset signals.

This modular structure allows the complete system to combine communication, configuration, processing, and CDC functionality while maintaining separate interfaces between the major subsystems.

---

## Development Roadmap

The system can be extended through additional functionality while maintaining the same modular architecture.

Potential areas for future development include:

- Additional ALU functions
- Expanded Register File addressing
- Additional UART configuration options
- More extensive system-level verification
- Additional status and diagnostic registers
- Extended command protocols
- Additional clock-management features

Such extensions can be incorporated through the existing `SYS_CTRL`, Register File, ALU, and communication interfaces.

---

## Reference

This README is based on the **Final System** project specification, including its defined system architecture, module interfaces, register organization, UART command protocol, clock domains, and system-level operation.

---

## Disclaimer

This README describes the architecture and intended organization of the project according to the provided specification. It is intended as project documentation and does not constitute a code review or verification report.