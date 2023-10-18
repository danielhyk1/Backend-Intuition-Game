\***\*INPROGRESS\*\***

Project Idea:

Using Oracle nodes to fetch off-chain data, users can place intuitive guesses using tokens for predicting data results.
Tokens are redistributed based on the pooled answers and answer variations. Ie. ranged inputs, multiple choice, or binary

Token Supply Mechanism

1. Rnadom Number Lottery with rewards as distributed spread

   - conducted at specific time intervals

2. trade testnet tokens for AAT tokens

**********\*\***********\*\*\*\***********\*\***********Dont allow transfer of tokens between people

## Backend Architecture:

Distributor: "Hub" or center of logic
Deploys: 1. AAT 2. SubDistribute 3. Lottery

AAT: Mints and sends only to Distribute

SubDistributor: Factory pattern with Distribute and will be parent of inherited SubDistributeTypes
Deploys: 1. SubDistributeType1 2. SubDistributeType2
Functions: 1. Receives AAT from users 2. Distributes AAT to winners

Lottery: Distributes AAT to users

---

1. Distribution contract controls the supply of the tokens

2. Distribution contract handles local distribution contracts

3. Local distribution contracts use pooled tokens to redistribute to users
