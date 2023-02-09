module NFT {
    using Address = address;

    struct Token {
        Address owner;
        u64 id;
    }

    resource struct NFT {
        map<u64, Token> tokens;
        u64 token_count;

        init(u64 count) {
            self.token_count = count;
        }

        // Creates a new token and assigns it to the given address
        fun create_token(Address owner, u64 id) : (Token) {
            assert(self.tokens[id].owner.is_null(), "Token with this ID already exists.");
            self.tokens[id] = Token{ owner, id };
            self.token_count += 1;
            return self.tokens[id];
        }

        // Transfers a token to a new owner
        fun transfer_token(u64 id, Address new_owner) {
            assert(!self.tokens[id].owner.is_null(), "Token with this ID does not exist.");
            self.tokens[id].owner = new_owner;
        }
    }
}
