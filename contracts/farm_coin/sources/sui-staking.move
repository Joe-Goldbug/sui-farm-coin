module staking_protocol::sui_staking {
    use staking_protocol::vault;
    use staking_protocol::farm;
    use sui::coin::{Coin, TreasuryCap};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    // ========== 核心功能 ==========

    /// 初始化整个质押系统
    public entry fun initialize(ctx: &mut TxContext) {
        vault::init(ctx);
        farm::init(farm::FARM {}, ctx);
    }

    /// 统一质押入口（整合SUI质押和奖励计算）
    public entry fun stake(
        payment: Coin<SUI>,
        vault: &mut vault::Vault,
        farm_treasury: &mut TreasuryCap<farm::FARM>,
        clock: &Clock,
        ctx: &mut TxContext
    ) {
        vault::stake(payment, vault, farm_treasury, clock, ctx);
    }

    /// 自动复投奖励（将FARM奖励转换为质押）
    public entry fun compound_rewards(
        rewards: Coin<farm::FARM>,
        vault: &mut vault::Vault,
        farm_treasury: &mut TreasuryCap<farm::FARM>,
        clock: &Clock,
        ctx: &mut TxContext
    ) {
        // ... 实现奖励复投逻辑 ...
    }

    // ========== 扩展功能 ==========
    
    /// 跨合约权限管理（使用Capability模式）
    struct StakingAdminCap has key { id: UID }

    /// 利率调整功能
    public entry fun adjust_rates(
        _: &StakingAdminCap,
        new_rate: u64,
        vault: &mut vault::Vault,
        ctx: &mut TxContext
    ) {
        // ... 实现利率调整逻辑 ...
    }

    // ========== 数据查询 ==========
    
    /// 获取总质押量
    public fun total_staked(vault: &vault::Vault): u64 {
        vault::total_staked(vault)
    }

    /// 查询用户待领取奖励
    public fun pending_rewards(user: address, vault: &vault::Vault): u64 {
        vault::pending_rewards(user, vault)
    }

    // ========== 测试函数 ==========
    #[test_only]
    public fun init_test_env(ctx: &mut TxContext) {
        initialize(ctx);
    }
}