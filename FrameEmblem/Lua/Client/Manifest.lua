--- 框架默认配置
--- @module Framework Global FrameworkConfig
--- @copyright Lilith Games, Avatar Team
local Manifest = {}

Manifest.ROOT_PATH = 'Lua/Client/'

Manifest.Events = {
    'NoticeEvent'
}

Manifest.Modules = {
    '/FrameEmblem/Runtime/Client/Client'
    --'Fsm/Base/ControllerBase',
    --'Fsm/Base/TransitonBase',
    --'Fsm/Base/StateBase',
    --'Fsm/PlayerAnimMgr',
    --[[
    'Fsm/PlayerActFsm/PlayerActController',
    'Fsm/PlayerActFsm/PlayerActState',
    'Fsm/PlayerActFsm/State/ActBeginState',
    'Fsm/PlayerActFsm/State/ActEndState',
    'Fsm/PlayerActFsm/State/ActState',
    'Fsm/PlayerActFsm/State/AttackPunch1State',
    'Fsm/PlayerActFsm/State/AttackPunch2State',
    'Fsm/PlayerActFsm/State/CrouchBeginState',
    'Fsm/PlayerActFsm/State/CrouchEndState',
    'Fsm/PlayerActFsm/State/CrouchIdleState',
    'Fsm/PlayerActFsm/State/CrouchMoveState',
    'Fsm/PlayerActFsm/State/DoubleJumpSprintState',
    'Fsm/PlayerActFsm/State/DoubleJumpState',
    'Fsm/PlayerActFsm/State/FallState',
    'Fsm/PlayerActFsm/State/FlyBeginState',
    'Fsm/PlayerActFsm/State/FlyEndState',
    'Fsm/PlayerActFsm/State/FlyIdleState',
    'Fsm/PlayerActFsm/State/FlyMoveState',
    'Fsm/PlayerActFsm/State/FlySprintBeginState',
    'Fsm/PlayerActFsm/State/FlySprintEndState',
    'Fsm/PlayerActFsm/State/FlySprintState',
    'Fsm/PlayerActFsm/State/IdleState',
    'Fsm/PlayerActFsm/State/JumpBeginState',
    'Fsm/PlayerActFsm/State/JumpHighestState',
    'Fsm/PlayerActFsm/State/JumpRiseState',
    'Fsm/PlayerActFsm/State/LandState',
    'Fsm/PlayerActFsm/State/LieBeginState',
    'Fsm/PlayerActFsm/State/LieEndState',
    'Fsm/PlayerActFsm/State/LieState',
    'Fsm/PlayerActFsm/State/MoveState',
    'Fsm/PlayerActFsm/State/MoveStopState',
    'Fsm/PlayerActFsm/State/OpenState',
    'Fsm/PlayerActFsm/State/PickUpHeavyBeginState',
    'Fsm/PlayerActFsm/State/PickUpHeavyEndState',
    'Fsm/PlayerActFsm/State/PickUpHeavyState',
    'Fsm/PlayerActFsm/State/PlayRockerState',
    'Fsm/PlayerActFsm/State/PunchBeginState',
    'Fsm/PlayerActFsm/State/PunchEndState',
    'Fsm/PlayerActFsm/State/PunchState',
    'Fsm/PlayerActFsm/State/RideState',
    'Fsm/PlayerActFsm/State/RunOnMachineState',
    'Fsm/PlayerActFsm/State/SitBeginState',
    'Fsm/PlayerActFsm/State/SitEndState',
    'Fsm/PlayerActFsm/State/SitState',
    'Fsm/PlayerActFsm/State/SwimBeginState',
    'Fsm/PlayerActFsm/State/SwimEndState',
    'Fsm/PlayerActFsm/State/SwimIdleState',
    'Fsm/PlayerActFsm/State/SwimmingEndState',
    'Fsm/PlayerActFsm/State/SwimmingStartState',
    'Fsm/PlayerActFsm/State/SwimmingState',
    'Fsm/PlayerActFsm/State/ThrowBeginState',
    'Fsm/PlayerActFsm/State/ThrowEndState',
    'Fsm/PlayerActFsm/State/ThrowState',
    'Fsm/PlayerActFsm/State/WadeMoveState',
    'Fsm/PlayerActFsm/State/WadeMoveStopState',
    'Fsm/PlayerActFsm/State/WadeState',
    'Fsm/PlayerActFsm/State/DrinkBeginState',
    'Fsm/PlayerActFsm/State/DrinkState',
    'Fsm/PlayerActFsm/State/DanceState',
    'Fsm/PlayerActFsm/State/WateringPlantBeginState',
    'Fsm/PlayerActFsm/State/WateringPlantEndState',
    'Fsm/PlayerActFsm/State/WateringPlantState',
    ]]
    --'Fsm/FsmMgr',
    --'Mgr/PlayerGuiDefault',
    --'Mgr/GuiControl',
    --'Mgr/PlayerCam',
    --'Mgr/PlayerCtrl'
}

return Manifest
