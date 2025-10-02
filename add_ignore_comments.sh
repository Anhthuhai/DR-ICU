#!/bin/bash

# Script để thêm ignore comments cho deprecated_member_use warnings
# Thêm comment trước dòng groupValue và onChanged trong RadioListTile

echo "🔧 Bắt đầu thêm ignore comments cho deprecated_member_use..."

# Tìm tất cả file .dart trong thư mục clinical_scores
find lib/features/clinical_scores/presentation -name "*.dart" -type f | while read file; do
    echo "📁 Đang xử lý: $file"
    
    # Tạo file tạm
    temp_file=$(mktemp)
    
    # Đọc file và thêm ignore comment
    while IFS= read -r line; do
        # Nếu dòng chứa "groupValue:" thì thêm ignore comment phía trước
        if [[ "$line" =~ ^[[:space:]]*groupValue: ]]; then
            # Lấy indentation của dòng hiện tại
            indent=$(echo "$line" | sed 's/\(^[[:space:]]*\).*/\1/')
            echo "${indent}// ignore: deprecated_member_use" >> "$temp_file"
            echo "$line" >> "$temp_file"
        # Nếu dòng chứa "onChanged:" thì thêm ignore comment phía trước  
        elif [[ "$line" =~ ^[[:space:]]*onChanged: ]]; then
            # Lấy indentation của dòng hiện tại
            indent=$(echo "$line" | sed 's/\(^[[:space:]]*\).*/\1/')
            echo "${indent}// ignore: deprecated_member_use" >> "$temp_file"
            echo "$line" >> "$temp_file"
        else
            echo "$line" >> "$temp_file"
        fi
    done < "$file"
    
    # Thay thế file gốc
    mv "$temp_file" "$file"
    
    echo "✅ Hoàn thành: $file"
done

echo "🎉 Hoàn thành tất cả!"
