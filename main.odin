package main

import rl       "vendor:raylib"
import imgui_rl "imgui_impl_raylib"
import imgui    "dependancies/odin-imgui"

SCREEN_HEIGHT : i32 = 800
SCREEN_WIDTH  : i32 = 800

circle_position : rl.Vector2 = { 400, 400 }

main :: proc() {
    rl.InitWindow(SCREEN_HEIGHT, SCREEN_WIDTH, "App Name")
    defer rl.CloseWindow()

    rl.SetTargetFPS(60)

    imgui.CreateContext(nil)
    defer imgui.DestroyContext(nil)

    imgui_rl.init()
    defer imgui_rl.shutdown()

    imgui_rl.build_font_atlas()
    
    // Game main loop:
    for !rl.WindowShouldClose() {
        imgui_rl.process_events()
		imgui_rl.new_frame()
		imgui.NewFrame()

        update_game()

        rl.BeginDrawing()

        render_game()

        render_ui()

        imgui.Render()
	    imgui_rl.render_draw_data(imgui.GetDrawData())

        rl.EndDrawing()
    }

}

update_game :: proc() {
    move_speed : f32 = 10;

    if rl.IsKeyDown(.UP) {
        circle_position.y -= move_speed
    }

    if rl.IsKeyDown(.DOWN) {
        circle_position.y += move_speed
    }

    if rl.IsKeyDown(.LEFT) {
        circle_position.x -= move_speed
    }

    if rl.IsKeyDown(.RIGHT) {
        circle_position.x += move_speed
    }
}

render_game :: proc() {
    // Clear background prevents that trippy effects like when you go off-map is cs.
    rl.ClearBackground(rl.RAYWHITE)

    rl.DrawCircle(cast(i32)circle_position.x, cast(i32)circle_position.y, 50, rl.RED)
}

render_ui :: proc() {
    imgui.ShowDemoWindow(nil)
}
