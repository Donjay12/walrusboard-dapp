module walrus_board::social {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use std::string::{String};

    public struct Board has key {
        id: UID,
    }

    public struct PostCreated has copy, drop {
        post_id: UID,
        creator: address,
        text_content: String,
        walrus_blob_id: String,
    }

    public struct Post has key, store {
        id: UID,
        creator: address,
        text_content: String,
        walrus_blob_id: String,
    }

    fun init(ctx: &mut TxContext) {
        let board = Board {
            id: object::new(ctx)
        };
        transfer::share_object(board);
    }

    public entry fun create_post(
        text_content: String,
        walrus_blob_id: String,
        ctx: &mut TxContext
    ) {
        let post = Post {
            id: object::new(ctx),
            creator: tx_context::sender(ctx),
            text_content,
            walrus_blob_id,
        };
        
        transfer::transfer(post, tx_context::sender(ctx));
    }
}
